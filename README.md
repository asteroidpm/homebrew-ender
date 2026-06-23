# Ender public distribution

This repository is the public home for Ender's downloadable tools. It is both:

- a **Homebrew tap** — `brew install asteroidpm/ender/<tool>` (macOS & Linux), and
- a **direct-download host** — every tool's cross-platform binaries are published as
  assets on this repo's [Releases](https://github.com/asteroidpm/homebrew-ender/releases)
  (macOS, Linux, and Windows).

## Tools

| Tool | Description |
|---|---|
| [`ender-payables-mcp`](#ender-payables-mcp) | Ender's public MCP server for creating payables (invoices) from unstructured input, via the Ender API. |

---

## ender-payables-mcp

A local [MCP](https://modelcontextprotocol.io) server that lets an AI agent (Claude
Desktop, Cursor, or any MCP-capable client) create invoices in Ender from unstructured
input. You run the binary on your own machine; it authenticates to the Ender public API
with your own `ender_live_` key. Nothing is hosted by Ender.

Full documentation: **[Payables MCP customer guide](https://docs.ender.com/customer-guides/public-api/mcp-server)**.

### Install

#### Option A — Homebrew (macOS & Linux) — recommended

```sh
brew install asteroidpm/ender/ender-payables-mcp
# auto-taps github.com/asteroidpm/homebrew-ender and puts
# ender-payables-mcp-server on your PATH (e.g. /opt/homebrew/bin or /home/linuxbrew/.linuxbrew/bin)
```

Upgrade later with `brew update && brew upgrade ender-payables-mcp`.

Homebrew is the smoothest macOS path: formula installs are not Gatekeeper-quarantined,
so the binary runs without any extra step.

#### Option B — direct download (macOS, Linux, **Windows**)

Windows has no Homebrew, so use this path there; it also works on macOS/Linux if you
prefer not to use brew. Grab the archive for your platform from the
[latest release](https://github.com/asteroidpm/homebrew-ender/releases/latest):

| Platform | Asset |
|---|---|
| macOS — Apple Silicon | `ender-payables-mcp-<version>-aarch64-apple-darwin.tar.gz` |
| macOS — Intel | `ender-payables-mcp-<version>-x86_64-apple-darwin.tar.gz` |
| Linux — x86_64 | `ender-payables-mcp-<version>-x86_64-unknown-linux-gnu.tar.gz` |
| Linux — arm64 | `ender-payables-mcp-<version>-aarch64-unknown-linux-gnu.tar.gz` |
| Windows — x86_64 | `ender-payables-mcp-<version>-x86_64-pc-windows-gnu.zip` |

Each release also publishes a `SHA256SUMS` file — **verify before running.**

**macOS / Linux:**

```sh
VERSION=0.1.0
BASE="https://github.com/asteroidpm/homebrew-ender/releases/download/v$VERSION"
ARCHIVE="ender-payables-mcp-$VERSION-aarch64-apple-darwin.tar.gz"   # pick your platform

curl -fsSLO "$BASE/$ARCHIVE"
curl -fsSLO "$BASE/SHA256SUMS"
shasum -a 256 -c SHA256SUMS --ignore-missing      # expect: <archive>: OK
tar -xzf "$ARCHIVE"
# binary: ender-payables-mcp-$VERSION-<target>/ender-payables-mcp-server
```

> **macOS note:** a binary downloaded this way (not via Homebrew) is quarantined by
> Gatekeeper and the binary is not yet notarized, so first launch is blocked with
> *"cannot be opened because the developer cannot be verified."* Clear the quarantine
> flag once after extracting:
> ```sh
> xattr -dr com.apple.quarantine ender-payables-mcp-*/ender-payables-mcp-server
> ```
> Homebrew (Option A) avoids this entirely — prefer it on macOS.

**Windows (PowerShell):**

```powershell
$Version = "0.1.0"
$Base = "https://github.com/asteroidpm/homebrew-ender/releases/download/v$Version"
$Archive = "ender-payables-mcp-$Version-x86_64-pc-windows-gnu.zip"

Invoke-WebRequest "$Base/$Archive" -OutFile $Archive
Invoke-WebRequest "$Base/SHA256SUMS" -OutFile SHA256SUMS
# verify (compare against the matching line in SHA256SUMS):
(Get-FileHash $Archive -Algorithm SHA256).Hash.ToLower()
Expand-Archive $Archive -DestinationPath .
# binary: ender-payables-mcp-$Version-x86_64-pc-windows-gnu\ender-payables-mcp-server.exe
```

### Configure your MCP client

Point your client at the installed/extracted binary and supply your key via `env`:

```json
{
  "mcpServers": {
    "ender-payables": {
      "command": "ender-payables-mcp-server",
      "env": {
        "ENDER_API_KEY": "ender_live_your_key_here"
      }
    }
  }
}
```

Use the absolute path for `command` if the binary isn't on your client's `PATH`
(e.g. `/opt/homebrew/bin/ender-payables-mcp-server`, or the extracted path on Windows).

| Variable | Required | Default | Purpose |
|---|---|---|---|
| `ENDER_API_KEY` | yes | — | Your `ender_live_` key, sent as `Authorization: Bearer`. |
| `ENDER_API_URL` | no | `https://api.ender.com` | Override the API base URL (e.g. a staging tenant). |
| `ENDER_PAYABLES_MCP_LOG_LEVEL` | no | `info` | Log verbosity; logs go to stderr only. |

Restart your client; the `ender-payables` tools should appear. If `ENDER_API_KEY` is
unset the server exits immediately with a setup message.

### Getting a key

You need an Ender public API key (`ender_live_…`). Keys are minted by Ender support —
contact them to have one issued for your firm. Store it in a secrets manager and treat
it as a long-lived credential.

### Verify it runs

```sh
ender-payables-mcp-server --help
```

### Releases & versioning

Binaries and checksums for every version live under
[Releases](https://github.com/asteroidpm/homebrew-ender/releases). The Homebrew formula
in [`Formula/`](./Formula) always tracks the latest published version.

---

*The compiled binaries are the only public artifact; the server source lives in Ender's
private monorepo. The binaries expose no secrets and only reach the public Ender API.*
