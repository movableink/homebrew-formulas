class Nsq < Formula
  desc "Realtime distributed messaging platform"
  homepage "https://nsq.io/"
  url "https://movableink-developer-binaries.s3-us-west-2.amazonaws.com/nsq_0.3.8_darwin.zip"
  sha256 "70fa07a13dd1d01039bca5ad03b72ee02eaf30da9e291d85e171d3e2a515284c"

  depends_on "movableink/formulas/nsqadmin"
  depends_on "movableink/formulas/nsqd"
  depends_on "movableink/formulas/nsqlookupd"
  depends_on "movableink/formulas/nsqutils"

  def install
    mkdir "#{bin}"
  end

  test do
    system "true"
  end
end
