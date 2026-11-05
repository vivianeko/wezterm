# WezTerm fork

This fork publishes Windows builds from upstream nightly commits with one
patch on top.

On Windows, upstream's `wm_paint` handler returns during its frame throttle
without validating the window's update region. Windows therefore re-sends
`WM_PAINT` whenever the message queue is empty, and the GUI thread, which every
window shares, spins until the throttle timer fires. A lower `max_fps` makes
the spin longer. The fix validates the region before returning, so the timer
alone schedules the next paint.


## Branches

- `windows-paint-throttle`: upstream's latest Windows nightly commit plus the
  fix as a single commit. A workflow rebases it whenever upstream publishes a
  new nightly.
- `macos-coretext`: an experimental CoreText font renderer for macOS, based
  on upstream PR #7979. It is no longer built or released; macOS uses
  upstream's nightly instead.
- `ci`: the default branch. It holds this file and the workflow file, because
  GitHub runs scheduled workflows from the default branch only. Keeping upstream's workflow files
  off the default branch means none of them run here.
- `main`: a mirror of upstream `main`. Nothing runs from it.

## Release

The `nightly` release holds `WezTerm-nightly-setup.exe`,
`WezTerm-windows-nightly.zip`, and their `.sha256` files. The workflow runs
twice a day, skips the build when the release already carries the current
fix commit, and rebuilds otherwise with upstream's own Windows steps. The
release notes name the upstream commit and the fork commit that were built.

If upstream changes `window/src/os/windows/window.rs` around `wm_paint`, the
rebase conflicts, the run fails, and the release stops advancing until the
branch is rebased by hand.
