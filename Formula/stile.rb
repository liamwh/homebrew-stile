class Stile < Formula
  desc "Capability-oriented secret broker: lifecycle operations for untrusted callers"
  homepage "https://github.com/liamwh/stile"
  version "0.1.1"
  license "Apache-2.0"

  # Linux only: the broker boundary is Unix sockets with SO_PEERCRED,
  # runuser and a privileged systemd service. There is no macOS port and
  # no launchd integration; this formula is a developer convenience that
  # installs binaries, NOT a stile deployment.
  depends_on :linux

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/liamwh/stile/releases/download/v0.1.1/stile-v0.1.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ef907c8e8f0e15016eb95b4a3b06cc4695937d989c128be09735975a33c4bcbb"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/liamwh/stile/releases/download/v0.1.1/stile-v0.1.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "42793f266b0a8d414a6dcd38bbc7438fbd178de19d4a0b93aa2fa0ccdc0b1fb9"
    end
  end

  def install
    bin.install "stile", "stile-brokerd"
    doc.install %w[README.md THREAT_MODEL.md SECURITY.md LICENSE]
  end

  def caveats
    <<~EOS
      stile is Linux-only: it relies on Unix domain sockets with
      SO_PEERCRED, runuser, and a privileged broker (stile-brokerd).
      Read THREAT_MODEL.md before use. Not independently audited.
    EOS
  end

  test do
    assert_match "stile", shell_output("#{bin}/stile --version")
  end
end
