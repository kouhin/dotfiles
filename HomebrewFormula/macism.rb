# Pinned to 4.0.0 because the upstream laishulu/homebrew tap is still on 3.1.1.
class Macism < Formula
  desc "macOS Input Source Manager"
  homepage "https://github.com/laishulu/macism"
  version "4.0.0"
  license "MIT" # Replace with the actual license from the repository if available

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/laishulu/macism/releases/download/v#{version}/macism-arm64"
      sha256 "36f367a206ce475840afed51fba0f9d286871cbb88cd2299f21801776bbf788b"
    else
      url "https://github.com/laishulu/macism/releases/download/v#{version}/macism-x86_64"
      sha256 "b3a7dabc4ba49a51beab999d9ee8cc10bdeb3e0c5978a9cf917dd15a8e9147b5"
    end
  end

  # Ensure the formula only runs on macOS
  depends_on :macos

  def install
    # Install the appropriate binary based on architecture, renaming to 'macism'
    bin.install "macism-arm64" => "macism" if OS.mac? && Hardware::CPU.arm?
    bin.install "macism-x86_64" => "macism" if OS.mac? && !Hardware::CPU.arm?
  end

  def caveats
    <<~EOS
      macism has been installed as a command-line tool.
      For more information on usage, see the project documentation:
        #{homepage}

      If you are using macism with TemporaryWindow.app, ensure it is installed separately.
    EOS
  end

  test do
    # Test that macism binary runs and outputs something meaningful (e.g., help or version)
    assert_match(/macism/, shell_output("#{bin}/macism 2>&1", 0))
  end
end
