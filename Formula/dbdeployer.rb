class Dbdeployer < Formula
  desc "Tool to deploy sandboxed MySQL database servers"
  homepage "https://github.com/datacharmer/dbdeployer"
  url "https://github.com/datacharmer/dbdeployer/archive/v1.54.1.tar.gz"
  sha256 "eef2fd66b88bb18b53adfa90ee20647c58d307d089a21e5ba9784fd2d079e836"
  license "Apache-2.0"
  head "https://github.com/datacharmer/dbdeployer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "eb02280d7a6ea9575942093e58a47661f549bf582b6f5ccc38e61b889d0aa798" => :catalina
    sha256 "2c2ecedf83ebfa8baa7150915198e127b3f668e2176cec1cf61349cae81df960" => :mojave
    sha256 "c676969502185010865857ed540219f73b73ffcd2bbf476b1357dee96e2396de" => :high_sierra
    sha256 "8ee5d033a60478c7d7829be6497b2b46b3eecb3f8108062b63332aaf316c9af5" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "./scripts/build.sh", OS.mac? ? "OSX" : "linux"
    bin.install "dbdeployer-#{version}.#{OS.mac? ? "osx" : "linux"}" => "dbdeployer"
    bash_completion.install "docs/dbdeployer_completion.sh"
  end

  test do
    shell_output("dbdeployer init --skip-shell-completion --skip-tarball-download")
    assert_predicate testpath/"opt/mysql", :exist?
    assert_predicate testpath/"sandboxes", :exist?
  end
end
