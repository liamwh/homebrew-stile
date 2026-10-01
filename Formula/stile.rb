class Stile < Formula
  desc "Capability-oriented secret broker: lifecycle operations for untrusted callers"
  homepage "https://github.com/liamwh/stile"
  version "0.1.0"
  license "Apache-2.0"

  # Linux only: the broker boundary is Unix sockets with SO_PEERCRED,
  # runuser and a privileged systemd service. There is no macOS port and
  # no launchd integration; this formula is a developer convenience that
  # installs binaries, NOT a stile deployment.
  depends_on :linux

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/liamwh/stile/releases/download/v0.1.0/stile-v0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "527fc1b7a7db334a38465c15290031d26acbb90a4806832e1182dcdeaf64a156"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/liamwh/stile/releases/download/v0.1.0/stile-v0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "942030119a418cb7b54c9b3258c30705bcef98c84ef3d3aa8f073f7d2c6a69c9"
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
