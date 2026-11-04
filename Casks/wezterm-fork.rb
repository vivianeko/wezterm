cask "wezterm-fork" do
  version "20261104-022957-4f18e7a0"
  sha256 "6c87a3aaaccab199632dafdebc3678ce13149b55ae521b3c44d768912c20125b"

  url "https://github.com/vivianeko/wezterm/releases/download/macos-#{version}/WezTerm-macos-nightly.zip"
  name "WezTerm"
  desc "Terminal emulator with native macOS CoreText rendering"
  homepage "https://github.com/vivianeko/wezterm"

  depends_on arch: :arm64
  conflicts_with cask: ["wezterm", "wezterm@nightly"]

  app "WezTerm-macos-#{version}/WezTerm.app"
  binary "#{appdir}/WezTerm.app/Contents/MacOS/wezterm"
  binary "#{appdir}/WezTerm.app/Contents/MacOS/wezterm-gui"
  binary "#{appdir}/WezTerm.app/Contents/MacOS/wezterm-mux-server"
  binary "#{appdir}/WezTerm.app/Contents/MacOS/strip-ansi-escapes"
  bash_completion "#{appdir}/WezTerm.app/Contents/Resources/shell-completion/bash", target: "wezterm"
  zsh_completion "#{appdir}/WezTerm.app/Contents/Resources/shell-completion/zsh", target: "_wezterm"
  fish_completion "#{appdir}/WezTerm.app/Contents/Resources/shell-completion/fish", target: "wezterm.fish"
end
