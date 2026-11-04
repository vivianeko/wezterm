# WezTerm fork

This fork publishes separate Windows and macOS builds from upstream nightly
commits. Each platform keeps its own patch branch and release.

On Windows, upstream's `wm_paint` handler returns during its frame throttle
without validating the window's update region. Windows therefore re-sends
`WM_PAINT` whenever the message queue is empty, and the GUI thread, which every
window shares, spins until the throttle timer fires. A lower `max_fps` makes
the spin longer. The fix validates the region before returning, so the timer
alone schedules the next paint.

On macOS, an experimental CoreText renderer uses the native font drawing APIs
instead of FreeType. Select it with `config.font_rasterizer = "CoreText"`.
The patch is based on upstream PR #7979. It does not change Windows rendering.

## Branches

- `windows-paint-throttle`: upstream's latest Windows nightly commit plus the
  fix as a single commit. A workflow rebases it whenever upstream publishes a
  new nightly.
- `macos-coretext`: upstream's latest macOS nightly commit plus the CoreText
  renderer. Its workflow rebases it independently of the Windows branch.
- `ci`: the default branch. It holds this file, the fork's Homebrew cask, and
  the two workflow files, because GitHub runs scheduled
  workflows from the default branch only. Keeping upstream's workflow files
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

The separate `macos-nightly` release holds `WezTerm-macos-nightly.zip` and its
SHA-256 file. It includes Apple Silicon and Intel binaries in one app. The
bundle is ad hoc signed and is not notarized by Apple. macOS builds and updates
do not block the Windows release.

The macOS workflow runs twice a day and skips a build that is already released.
Workflow pull requests build and test an artifact without publishing it. Manual
runs also produce artifacts by default; enable `publish` to update the release.
The `source_ref` input can validate another branch or commit, but cannot be
combined with publication.

Each published macOS build updates `Casks/wezterm-fork.rb` with its exact
version and SHA-256. Install it through the `vivianeko/wezterm` tap, using
`https://github.com/vivianeko/wezterm` as the tap URL. This keeps Homebrew
updates on the fork rather than replacing the app with an upstream build.
