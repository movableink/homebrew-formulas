class Nsq < Formula
  desc "Realtime distributed messaging platform"
  homepage "https://nsq.io/"
  url "https://movableink-developer-binaries.s3-us-west-2.amazonaws.com/nsq_0.3.8_darwin.zip"
  sha256 "4df0a59b8e82c9502467b94df0ef5135457033751d9ff3239076539e1c6ea22e"

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
