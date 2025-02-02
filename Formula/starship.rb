class Starship < Formula
  desc "Cross-shell prompt for astronauts"
  homepage "https://starship.rs"
  url "https://github.com/starship/starship/archive/v0.45.2.tar.gz"
  sha256 "99bbcd2eb0437627741feba5eb7c7b208334146ef2c5ffb5ceaafebf32bdde2a"
  license "ISC"
  head "https://github.com/starship/starship.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "8570535e0016940a4418bb7759e6f7042217bd0e39c62e446393d95c2165709c" => :catalina
    sha256 "1470dcd2c1848d73d595488f8a95455f1f6ff8377f8be15a0c2e11fa6bf3c5b7" => :mojave
    sha256 "0fa14e4941e4d8551955f29a4378e27a9f1b099c4a7d543263582fa3c2e96442" => :high_sierra
    sha256 "cf21237bbe5caa4f49986d73d4a3eea4518b65855dcb83f15bde2b8e3a601491" => :x86_64_linux
  end

  depends_on "rust" => :build
  unless OS.mac?
    depends_on "pkg-config" => :build
    depends_on "openssl@1.1"
  end

  uses_from_macos "zlib"

  def install
    system "cargo", "install", *std_cargo_args

    bash_output = Utils.safe_popen_read("#{bin}/starship", "completions", "bash")
    (bash_completion/"starship").write bash_output

    zsh_output = Utils.safe_popen_read("#{bin}/starship", "completions", "zsh")
    (zsh_completion/"_starship").write zsh_output

    fish_output = Utils.safe_popen_read("#{bin}/starship", "completions", "fish")
    (fish_completion/"starship.fish").write fish_output
  end

  test do
    ENV["STARSHIP_CONFIG"] = ""
    assert_equal "[1;32m❯[0m ", shell_output("#{bin}/starship module character")
  end
end
