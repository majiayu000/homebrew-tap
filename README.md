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

## Choose the intended formula and command

A fully qualified formula name selects this tap when another tap offers a similar
name. For example, to inspect and install this distribution of remem:

```bash
brew info --formula majiayu000/tap/remem
brew install majiayu000/tap/remem
remem --version
```

`brew info` and [Formula/](Formula/) show this tap's pinned release. An upstream
release announcement does not mean the formula already points to that release.
After installation, follow the upstream project's setup guide; remem's agent hooks
and a gateway's runtime configuration are separate from copying an executable.

### Which AtlasCloud distribution do I want?

This tap's `atlascloud-cli` v0.1.0 archives expose `atlas` and `atlas-mcp`.
The separately maintained [AtlasCloudAI tap](https://github.com/AtlasCloudAI/homebrew-tap#readme)
uses the formula name `atlascloud` and exposes `atlas`. Inspect the source and
version before choosing a distribution:

```bash
brew info --formula majiayu000/tap/atlascloud-cli
brew info --formula AtlasCloudAI/tap/atlascloud
command -v atlas
atlas version
```

Both can expose the same command name. Resolve any existing installation/link
conflict deliberately using Homebrew's output; installing one formula is not a
migration procedure for the other distribution.

## Support and upstream documentation

For a formula URL, checksum, build, or linking failure, open
[a tap issue](https://github.com/majiayu000/homebrew-tap/issues) with the fully
qualified formula, OS/architecture, pinned version, and exact error. For runtime
behavior, use the relevant upstream project's issue tracker from the table above.
Package licenses are declared in each formula and maintained by their upstream
projects; this tap is not a shared application with one setup or runtime license.

[Homebrew's tap documentation](https://docs.brew.sh/Taps) explains tap names and
fully qualified formula selection.
