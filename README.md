# Homebrew tap for developer tools

Homebrew formulae for [remem](https://github.com/majiayu000/remem),
[ccstats](https://github.com/majiayu000/ccstats),
[rust-litellm-gateway](https://github.com/majiayu000/litellm-rs), and AtlasCloud CLI.
This repository distributes packages; application source and usage documentation live upstream.

## Install

With [Homebrew](https://brew.sh/) installed, choose a formula:

```bash
brew tap majiayu000/tap
brew install remem
# Or: brew install ccstats
# Or: brew install rust-litellm-gateway
# Or: brew install atlascloud-cli
```

| Formula | Installed command | Documentation | Platforms in this tap |
| --- | --- | --- | --- |
| [`remem`](Formula/remem.rb) | `remem` | [Agent memory and integration](https://github.com/majiayu000/remem#readme) | macOS and Linux, Intel and ARM64 |
| [`ccstats`](Formula/ccstats.rb) | `ccstats` | [Usage statistics](https://github.com/majiayu000/ccstats#readme) | Builds from source with Rust |
| [`rust-litellm-gateway`](Formula/rust-litellm-gateway.rb) | `gateway` | [AI gateway](https://github.com/majiayu000/litellm-rs#readme) | macOS, Intel and Apple Silicon |
| [`atlascloud-cli`](Formula/atlascloud-cli.rb) | `atlas`, `atlas-mcp` | [Pinned distribution release](https://github.com/majiayu000/homebrew-tap/releases/tag/atlascloud-cli-v0.1.0) | macOS and Linux, Intel and ARM64 |

After installing remem, follow its upstream integration instructions or run `brew info remem`
for the tap's configuration steps. Installing the binary alone does not configure agent hooks.

The `atlascloud-cli` formula in this tap distributes the pinned v0.1.0 archives mirrored in
this repository. For the separately maintained AtlasCloud CLI distribution, see
[AtlasCloudAI/cli](https://github.com/AtlasCloudAI/cli#install) and its Homebrew instructions.

## Update or remove

```bash
brew update
brew upgrade remem       # Replace with the formula you installed
brew uninstall remem
```

Formula versions and download checksums are recorded in [`Formula/`](Formula/).
