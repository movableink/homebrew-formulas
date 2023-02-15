class ApachePulsar < Formula
  desc "Cloud-native distributed messaging and streaming platform"
  homepage "https://pulsar.apache.org/"
  url "https://www.apache.org/dyn/mirrors/mirrors.cgi?action=download&filename=pulsar/pulsar-2.11.0/apache-pulsar-2.11.0-bin.tar.gz"
  sha256 "a19dbdc52d45093e112bc2dc17c80c61094ebe096b0460fb28c3326e2cdf0938"
  version "2.11.0"
  license "Apache-2.0"

  depends_on "protobuf" => :build
  depends_on "openjdk"

  def install
    libexec.install Dir["*"]
    (etc/"pulsar").install_symlink libexec/"conf"

    libexec.glob("bin/*") do |path|
      if !path.fnmatch?("*common.sh") && !path.directory?
        bin_name = path.basename
        (bin/bin_name).write_env_script libexec/"bin"/bin_name, Language::Java.java_home_env("19")
      end
    end
  end

  def post_install
    (var/"log/pulsar").mkpath
  end

  service do
    run [bin/"pulsar", "standalone"]
    log_path var/"log/pulsar/output.log"
    error_log_path var/"log/pulsar/error.log"
  end
end
