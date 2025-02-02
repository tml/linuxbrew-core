class Argo < Formula
  desc "Get stuff done with container-native workflows for Kubernetes"
  homepage "https://argoproj.io"
  url "https://github.com/argoproj/argo.git",
      tag:      "v2.11.1",
      revision: "13b51d569d580ab9493e977fe2944889784d2a0a"
  license "Apache-2.0"

  bottle do
    cellar :any_skip_relocation
    sha256 "5168fac2d23e63a91a1dfe0c58a1364ebdd2443ebe514874fd86f8d0ffe5c147" => :catalina
    sha256 "3cb8ffc160b9355b5f3263c7d808b34f1c57f3a0eaf45c04612a6cec4e72f854" => :mojave
    sha256 "619f84351c6bb3fdcc78123b32c6efae5687dbe3aa39d21c7b68724fff36893a" => :high_sierra
    sha256 "a8275166d387f7136e7ff82e0490bd7cc1e6e66a411b8a7bb2d7e98d5e88a13f" => :x86_64_linux
  end

  depends_on "go" => :build
  depends_on "node" => :build
  depends_on "yarn" => :build

  def install
    # this needs to be remove to prevent multiple 'operation not permitted' errors
    inreplace "Makefile", "CGO_ENABLED=0", ""
    system "make", "dist/argo"
    bin.install "dist/argo"

    output = Utils.safe_popen_read("#{bin}/argo", "completion", "bash")
    (bash_completion/"argo").write output
    output = Utils.safe_popen_read("#{bin}/argo", "completion", "zsh")
    (zsh_completion/"_argo").write output
  end

  test do
    assert_match "argo is the command line interface to Argo",
      shell_output("#{bin}/argo --help")

    # argo consumes the Kubernetes configuration with the `--kubeconfig` flag
    # Since it is an empty file we expect it to be invalid
    touch testpath/"kubeconfig"
    assert_match "invalid configuration",
      shell_output("#{bin}/argo lint --kubeconfig ./kubeconfig 2>&1", 1)
  end
end
