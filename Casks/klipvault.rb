cask "klipvault" do
  version "1.0.0"
  sha256 "e734d0f9a6ef8b38e8332182502cd7bd6d08790d4631dd2aaafa766d80c92c2d"

  url "https://github.com/r0wh4n/Klipvault/releases/download/v#{version}/Klipvault-#{version}.zip"
  name "Klipvault"
  desc "Encrypted clipboard manager for the menu bar"
  homepage "https://github.com/r0wh4n/Klipvault"

  depends_on macos: :sonoma

  app "Klipvault.app"

  # Klipvault is ad-hoc signed rather than notarized, so Gatekeeper would refuse to
  # launch the downloaded copy. Clearing the flag here keeps the install a one-liner.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Klipvault.app"]
  end

  uninstall quit: "app.klipvault"

  # Only on `brew uninstall --zap`: this deletes your encrypted clipboard history.
  zap trash: [
    "~/Library/Application Support/Klipvault",
    "~/Library/Preferences/app.klipvault.plist",
  ]
end
