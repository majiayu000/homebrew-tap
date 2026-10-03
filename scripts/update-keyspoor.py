#!/usr/bin/env python3
"""Pin Keyspoor's latest stable release after verifying all distributed assets."""

import hashlib
import json
from pathlib import Path
import re
from urllib.request import Request, urlopen


REPO = "majiayu000/keyspoor"
FORMULA = Path(__file__).resolve().parents[1] / "Formula/keyspoor.rb"


def download(url):
    request = Request(url, headers={"User-Agent": "keyspoor-homebrew-updater"})
    with urlopen(request, timeout=60) as response:
        return response.read()


def main():
    release = json.loads(download(f"https://api.github.com/repos/{REPO}/releases/latest"))
    tag = release["tag_name"]
    if release["draft"] or release["prerelease"] or not re.fullmatch(r"v\d+\.\d+\.\d+", tag):
        raise ValueError(f"Expected a stable vX.Y.Z release, received {tag!r}")
    base = f"https://github.com/{REPO}/releases/download/{tag}"
    checksums = {}
    for line in download(f"{base}/SHA256SUMS").decode().splitlines():
        digest, name = line.split(maxsplit=1)
        if not re.fullmatch(r"[0-9a-f]{64}", digest) or name in checksums:
            raise ValueError("Invalid or duplicate SHA256SUMS entry")
        checksums[name] = digest

    targets = {
        "macos": {"intel": "x86_64-apple-darwin", "arm": "aarch64-apple-darwin"},
        "linux": {"intel": "x86_64-unknown-linux-gnu", "arm": "aarch64-unknown-linux-gnu"},
    }
    names = [f"keyspoor-{tag}-{target}" for cpus in targets.values() for target in cpus.values()]
    names += ["LICENSE", "THIRD_PARTY_NOTICES"]
    for name in names:
        actual = hashlib.sha256(download(f"{base}/{name}")).hexdigest()
        if actual != checksums[name]:
            raise ValueError(f"SHA256 mismatch: {name}")

    formula = f'''class Keyspoor < Formula
  desc "Secret scanner with redacted output and agent-friendly interfaces"
  homepage "https://github.com/{REPO}"
  license "Apache-2.0"
'''
    for os_name, cpus in targets.items():
        formula += f"\n  on_{os_name} do\n"
        for cpu, target in cpus.items():
            name = f"keyspoor-{tag}-{target}"
            formula += f'''    on_{cpu} do
      url "{base}/{name}"
      sha256 "{checksums[name]}"
    end
'''
        formula += "  end\n"
    for name in ["LICENSE", "THIRD_PARTY_NOTICES"]:
        formula += f'''
  resource "{name}" do
    url "{base}/{name}"
    sha256 "{checksums[name]}"
  end
'''
    formula += '''
  def install
    bin.install File.basename(stable.url) => "keyspoor"
    resource("LICENSE").stage { prefix.install "LICENSE" }
    resource("THIRD_PARTY_NOTICES").stage { prefix.install "THIRD_PARTY_NOTICES" }
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/keyspoor --version")
    (testpath/"clean.txt").write "nothing sensitive here\\n"
    clean = JSON.parse(shell_output("#{bin}/keyspoor scan #{testpath}/clean.txt"))
    assert_empty clean.fetch("findings")
    token = "ghp_" + "9Zb2Ef7hIj4kLm6nOp8qRs0tUv3wXy5zAbCd"
    (testpath/"secret.txt").write "token=#{token}\\n"
    output = shell_output("#{bin}/keyspoor scan #{testpath}/secret.txt", 1)
    refute_empty JSON.parse(output).fetch("findings")
    refute_match token, output
  end
end
'''
    FORMULA.write_text(formula)
    print(f"Verified six release assets and pinned Keyspoor {tag}")


if __name__ == "__main__":
    main()
