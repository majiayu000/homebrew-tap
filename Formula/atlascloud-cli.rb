# typed: false
# frozen_string_literal: true

# Initially pushed by hand for v0.1.0 because goreleaser's automatic
# tap push failed due to a GitHub Actions secret-passing issue (see
# fix in v0.1.1+). Subsequent releases will overwrite this file
# from CI once the workflow is fixed.
class AtlascloudCli < Formula
  desc "CLI for AtlasCloud — call 100+ LLM, image, and video models"
  homepage "https://github.com/majiayu000/atlascloud-cli"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/majiayu000/atlascloud-cli/releases/download/v0.1.0/atlascloud-cli_0.1.0_darwin_amd64.tar.gz"
      sha256 "73f582f4053bb223c6870ee31b13e202766f566a96018231ac0abe0fb8ec435d"
    end
    on_arm do
      url "https://github.com/majiayu000/atlascloud-cli/releases/download/v0.1.0/atlascloud-cli_0.1.0_darwin_arm64.tar.gz"
      sha256 "8f47e346b6913f3cbbc4a025613eeeee2ff1cf488abec657f70fed1341d9db92"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/majiayu000/atlascloud-cli/releases/download/v0.1.0/atlascloud-cli_0.1.0_linux_amd64.tar.gz"
      sha256 "ee388606ad442e4a023a2687c1a77fb563e61e7c753b9b5a1eb19d545f33fbff"
    end
    on_arm do
      url "https://github.com/majiayu000/atlascloud-cli/releases/download/v0.1.0/atlascloud-cli_0.1.0_linux_arm64.tar.gz"
      sha256 "73fa90e6743c41f3ced183c644b18f60de1b1e060951e402b2bd1192873e5ddf"
    end
  end

  def install
    bin.install "atlas"
    bin.install "atlas-mcp"
  end

  test do
    system "#{bin}/atlas", "version"
    system "#{bin}/atlas-mcp", "version"
  end
end
