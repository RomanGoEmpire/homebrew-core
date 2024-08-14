class Ktfmt < Formula
  desc "Kotlin code formatter"
  homepage "https://facebook.github.io/ktfmt/"
  url "https://github.com/facebook/ktfmt/archive/refs/tags/v0.52.tar.gz"
  sha256 "0293799e3a2734b83379fb31fb4522a6dbe3882aec50447778e16cf54ebbf454"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "4046973aa73aa2decf3bf540866bf264885ea962945d0417dac0e453b4a1a4bc"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "f4633eed12e0a7d03df41624ca88d3a25d79516b274d3bfbf52a0bfad103f9a6"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4ac39b1493a0fd387bcbdd8271d3dc70c54ae504299264de75d6d1926af59639"
    sha256 cellar: :any_skip_relocation, sonoma:         "72cf6bcb63ac7d9d2c640448ff25fc2402005b787d401a84cffe9a51609e6162"
    sha256 cellar: :any_skip_relocation, ventura:        "229b92464bb74f0308f9df2fa0ab577d9a8d0fefe9e6db43f0839019abe84996"
    sha256 cellar: :any_skip_relocation, monterey:       "46b17ce0d8dd14bc2ce92ef658ac59a64982adf0d66f2a602e4ab6cb17650595"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4fdc5694531f2ddfaef94e60e6776caf7ec01b7a21fb9aece33560a701cdc5ae"
  end

  depends_on "maven" => :build
  depends_on "openjdk"

  def install
    ENV["JAVA_HOME"] = Formula["openjdk"].opt_prefix
    system "mvn", "clean", "package", "-DskipTests=true", "-Dmaven.javadoc.skip=true"
    libexec.install "core/target/ktfmt-#{version}-jar-with-dependencies.jar"
    bin.write_jar_script libexec/"ktfmt-#{version}-jar-with-dependencies.jar", "ktfmt"
  end

  test do
    test_file = testpath/"Test.kt"
    test_file.write <<~EOS
      fun main() { println("Hello, World!") }
    EOS

    output = shell_output("#{bin}/ktfmt --google-style #{test_file} 2>&1")
    assert_match "Done formatting #{test_file}", output
    assert_equal <<~EOS, test_file.read
      fun main() {
        println("Hello, World!")
      }
    EOS
  end
end
