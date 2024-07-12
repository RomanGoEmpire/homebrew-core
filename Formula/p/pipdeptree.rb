class Pipdeptree < Formula
  include Language::Python::Virtualenv

  desc "CLI to display dependency tree of the installed Python packages"
  homepage "https://github.com/tox-dev/pipdeptree"
  url "https://files.pythonhosted.org/packages/2b/1f/9bbf4f001befee00c050051f8f6e7971b41e2716784949989c7e856bf625/pipdeptree-2.23.1.tar.gz"
  sha256 "ebc9b232d7e8ca061826f1875fd4ccc823930f84f327d302019d2ca856f50973"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "c61a8c4e9108693440d5e7d02a46e9e06e60764ae85b39763de42c9202dfebf2"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c61a8c4e9108693440d5e7d02a46e9e06e60764ae85b39763de42c9202dfebf2"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c61a8c4e9108693440d5e7d02a46e9e06e60764ae85b39763de42c9202dfebf2"
    sha256 cellar: :any_skip_relocation, sonoma:         "8e9c6de0275aed30690d9ce9546de77a28062a704cd612c3afcf106142ec0f92"
    sha256 cellar: :any_skip_relocation, ventura:        "8e9c6de0275aed30690d9ce9546de77a28062a704cd612c3afcf106142ec0f92"
    sha256 cellar: :any_skip_relocation, monterey:       "8e9c6de0275aed30690d9ce9546de77a28062a704cd612c3afcf106142ec0f92"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d1fa68d61ecfc833e44657333116e3f866b2e5b15d349bb47f17cec8f3146504"
  end

  depends_on "python@3.12"

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/51/65/50db4dda066951078f0a96cf12f4b9ada6e4b811516bf0262c0f4f7064d4/packaging-24.1.tar.gz"
    sha256 "026ed72c8ed3fcce5bf8950572258698927fd1dbda10a5e981cdf0ac37f4f002"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "pipdeptree==#{version}", shell_output("#{bin}/pipdeptree --all")

    assert_empty shell_output("#{bin}/pipdeptree --user-only").strip

    assert_equal version.to_s, shell_output("#{bin}/pipdeptree --version").strip
  end
end
