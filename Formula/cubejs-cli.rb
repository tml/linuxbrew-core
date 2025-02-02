require "language/node"

class CubejsCli < Formula
  desc "Cube.js command-line interface"
  homepage "https://cube.dev/"
  url "https://registry.npmjs.org/cubejs-cli/-/cubejs-cli-0.20.11.tgz"
  sha256 "87e9211ed4013d1056d16e5657b1d2948e571703d39aff3b60a63f7473613304"
  license "Apache-2.0"

  livecheck do
    url :stable
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "a27f9c45a1e20108cd7ceef68c51f193b53fbe50e51597b9ee18a5ccccfa0c5f" => :catalina
    sha256 "c70d8487777bfa2b0a1e2e1a2351a2c054ca260e394a1342871d189f463c378d" => :mojave
    sha256 "0f0fc1591a956d016cc9b3afa9dba4db7c7dc80b334f531f01b7c78a148276bb" => :high_sierra
    sha256 "88ea6550a757bc5c2e06ce48acef5da07d0618a4e748e76726a1ec6af2f34584" => :x86_64_linux
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cubejs --version")
    system "cubejs", "create", "hello-world", "-d", "postgres"
    assert_predicate testpath/"hello-world/schema/Orders.js", :exist?
  end
end
