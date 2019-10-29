class Nsq < Formula
  desc "Realtime distributed messaging platform"
  homepage "https://nsq.io/"
  url "https://movableink-developer-binaries.s3-us-west-2.amazonaws.com/nsq_0.3.8_darwin.zip"
  sha256 "92067e42af27b8a15e5f037e2cb9014858ec369140ce76b5aedd563bf1c2ccf8"

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
