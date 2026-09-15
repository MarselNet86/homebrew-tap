# Rendered from packaging/homebrew/peekle.rb in MarselNet86/peekle. From
# 0.1.4 on, release.yml attaches the rendered cask to every release and
# bump.yml copies it here; edit the template there, never this file.
cask "peekle" do
  version "0.1.3"
  sha256 "a72c8f6ef35c700c4d5f80418454c405d3f670085ba85c7afc454ce0daec5c0f"

  url "https://github.com/MarselNet86/peekle/releases/download/v#{version}/Peekle-mac-universal.dmg"
  name "Peekle"
  desc "Claude Code, answered from the notch"
  homepage "https://github.com/MarselNet86/peekle"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "Peekle.app"

  # The bundle is signed ad hoc, not notarized. Homebrew marks what it
  # downloads as quarantined, and Gatekeeper would refuse the app on its
  # first launch; clearing the mark is what makes this the supported way to
  # install.
  postflight do
    system_command "/usr/bin/xattr", args: ["-cr", "#{appdir}/Peekle.app"]
  end

  uninstall quit: "app.peekle.overlay"

  zap trash: [
    "~/Library/Application Support/peekle",
    "~/Library/Caches/app.peekle.overlay",
    "~/Library/Caches/peekle",
    "~/Library/HTTPStorages/app.peekle.overlay",
    "~/Library/Preferences/app.peekle.overlay.plist",
    "~/Library/WebKit/app.peekle.overlay",
  ]

  caveats <<~EOS
    Peekle listens to Claude Code through hooks. The `peekle` command that
    wires them ships inside the app from 0.1.4; for this version build it
    once with cargo, then:

      cargo install --git https://github.com/MarselNet86/peekle peekle-cli
      peekle init

    Then open Peekle. `peekle uninstall` takes the hooks out again.
  EOS
end
