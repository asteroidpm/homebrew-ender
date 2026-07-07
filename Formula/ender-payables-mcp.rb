# ender-payables-mcp v0.3.0 — binaries hosted on GitHub Releases (interim);
# dl.ender.com CDN is the eventual channel. Checksums match the published release assets.
class EnderPayablesMcp < Formula
  desc "Ender public MCP server for creating payables (invoices) via the Ender API"
  homepage "https://docs.ender.com/customer-guides/public-api/mcp-server"
  version "0.3.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/asteroidpm/homebrew-ender/releases/download/v0.3.0/ender-payables-mcp-0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "5cc633e0808a492d1bd7781beb3f73dc4d0edd4e45110e86d65814f3836d7243"
    end
    on_intel do
      url "https://github.com/asteroidpm/homebrew-ender/releases/download/v0.3.0/ender-payables-mcp-0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "8e1075984e0f1102c960e1ca2516c7e3abcf9486f4a0f2c2a05bf5530c42e9cc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/asteroidpm/homebrew-ender/releases/download/v0.3.0/ender-payables-mcp-0.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ac3f9cf977df9ba6c94a69ae88dc5e9f9478c2b5cdbc64a2ede36da1c24cab95"
    end
    on_intel do
      url "https://github.com/asteroidpm/homebrew-ender/releases/download/v0.3.0/ender-payables-mcp-0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2d77a92e87a3e67ad6982761cee13f5519e5de136d94f748e866a19628099c67"
    end
  end

  def install
    bin.install "ender-payables-mcp-server"
  end

  test do
    assert_match "ender-payables-mcp-server", shell_output("#{bin}/ender-payables-mcp-server --help 2>&1", 2)
  end
end
