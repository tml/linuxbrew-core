class GandiCli < Formula
  include Language::Python::Virtualenv

  desc "Command-line interface to Gandi.net products using the public API"
  homepage "https://cli.gandi.net/"
  url "https://files.pythonhosted.org/packages/cf/00/ff5acd1c9a0cfbb1a81a9f44ef4a745f31bb413869ae93295f8f5778cc4c/gandi.cli-1.6.tar.gz"
  sha256 "af59bf81a5a434dd3a5bc728a9475d80491ed73ce4343f2c1f479cbba09266c0"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "f54b377a3d3b9bf27145ab79de68adea3c5188c499b4e64736b03809d0ad6345" => :catalina
    sha256 "ea2d35473cd69b8f7b1eda66d31b8ed3365b9513918bf86177c66c1251de9e11" => :mojave
    sha256 "3888020e1fd0042fdb57bc82340d8d34eb39f098e2748cedb0e423b5f47f7924" => :high_sierra
    sha256 "9576fc50cee120c59f3241b166981efff133dd870fed4c61105cd22c2d01068c" => :x86_64_linux
  end

  depends_on "python@3.8"

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/40/a7/ded59fa294b85ca206082306bba75469a38ea1c7d44ea7e1d64f5443d67a/certifi-2020.6.20.tar.gz"
    sha256 "5930595817496dd21bb8dc35dad090f1c2cd0adfaf21204bf6732ca5d8ee34d3"
  end

  resource "chardet" do
    url "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz"
    sha256 "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/27/6f/be940c8b1f1d69daceeb0032fee6c34d7bd70e3e649ccac0951500b4720e/click-7.1.2.tar.gz"
    sha256 "d2b5255c7c6349bc1bd1e59e08cd12acbbd63ce649f2588755783aa94dfb6b1a"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/ea/b7/e0e3c1c467636186c39925827be42f16fee389dc404ac29e930e9136be70/idna-2.10.tar.gz"
    sha256 "b307872f855b18632ce0c21c5e45be78c0ea7ae4c15c828c20788b26921eb3f6"
  end

  resource "IPy" do
    url "https://files.pythonhosted.org/packages/e1/66/b6dd22472bb027556849876beae2dd4dca3a4eaf2dd3039277b4edb8c6af/IPy-1.00.tar.gz"
    sha256 "2f2bf658a858d43868d8a4352b3889cf78c66e2ce678b300dcf518c9149ba621"
  end

  resource "PyYAML" do
    url "https://files.pythonhosted.org/packages/64/c2/b80047c7ac2478f9501676c988a5411ed5572f35d1beff9cae07d321512c/PyYAML-5.3.1.tar.gz"
    sha256 "b8eac752c5e14d3eca0e6dd9199cd627518cb5ec06add0de9d32baeee6fe645d"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/da/67/672b422d9daf07365259958912ba533a0ecab839d4084c487a5fe9a5405f/requests-2.24.0.tar.gz"
    sha256 "b3559a131db72c33ee969480840fff4bb6dd111de7dd27c8ee1f820f4f00231b"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/81/f4/87467aeb3afc4a6056e1fe86626d259ab97e1213b1dfec14c7cb5f538bf0/urllib3-1.25.10.tar.gz"
    sha256 "91056c15fa70756691db97756772bb1eb9678fa585d9184f24534b100dc60f4a"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/gandi", "--version"
  end
end
