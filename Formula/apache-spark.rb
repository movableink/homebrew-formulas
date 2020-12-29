class ApacheSpark < Formula
  desc "Engine for large-scale data processing"
  homepage "https://spark.apache.org/"
  url "https://archive.apache.org/dist/spark/spark-2.2.3/spark-2.2.3-bin-hadoop2.7.tgz"
  version "2.2.3"
  sha256 "e964a28e797707a2924c8d29b0c2f4bca2b58c893b1e3207d70e0cd40dfd2758"
  head "https://github.com/apache/spark.git"

  bottle :unneeded

  depends_on "openjdk"

  def install
    # Rename beeline to distinguish it from hive's beeline
    mv "bin/beeline", "bin/spark-beeline"

    rm_f Dir["bin/*.cmd"]
    libexec.install Dir["*"]
    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", Language::Java.java_home_env("1.8"))
  end

  test do
    assert_match "Long = 1000", pipe_output(bin/"spark-shell --conf spark.driver.bindAddress=127.0.0.1", "sc.parallelize(1 to 1000).count()")
  end
end
