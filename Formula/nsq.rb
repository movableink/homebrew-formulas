class Nsq < Formula
  desc "Realtime distributed messaging platform"
  homepage "https://nsq.io/"
  url "https://movableink-developer-binaries.s3-us-west-2.amazonaws.com/nsq_0.3.8_darwin.zip"
  sha256 "7ac121e06df0a08b63b646064ec6710ee70e9bde89272ef502ea9b5ae8039bc6"

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
