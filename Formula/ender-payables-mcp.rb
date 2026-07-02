# ender-payables-mcp v0.2.0 — binaries hosted on GitHub Releases (interim);
# dl.ender.com CDN is the eventual channel. Checksums match the published release assets.
class EnderPayablesMcp < Formula
  desc "Ender public MCP server for creating payables (invoices) via the Ender API"
  homepage "https://docs.ender.com/customer-guides/public-api/mcp-server"
  version "0.2.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/asteroidpm/homebrew-ender/releases/download/v0.2.0/ender-payables-mcp-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "a748ce4ecd45184459a48f3a11fe8d331e82e50c7d19bd3d91c114b2b2f2aa46"
    end
    on_intel do
      url "https://github.com/asteroidpm/homebrew-ender/releases/download/v0.2.0/ender-payables-mcp-0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "8fa9d92d8c6f354780777dde0cb07d96285ad014ee437c37753bc05b55d6fb84"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/asteroidpm/homebrew-ender/releases/download/v0.2.0/ender-payables-mcp-0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a17c033743810ad7fa215504b7dce49b33a1fc4f80acdae5e2de0c7a3857b522"
    end
    on_intel do
      url "https://github.com/asteroidpm/homebrew-ender/releases/download/v0.2.0/ender-payables-mcp-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2abcdc776da7e024968dc0857f0314e884adfb5c4169918e01a34a3e6bf298be"
    end
  end

  def install
    bin.install "ender-payables-mcp-server"
  end

  test do
    assert_match "ender-payables-mcp-server", shell_output("#{bin}/ender-payables-mcp-server --help 2>&1", 2)
  end
end
