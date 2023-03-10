class Nsq < Formula
  desc "Realtime distributed messaging platform"
  homepage "https://nsq.io/"
  url "https://movableink-developer-binaries.s3-us-west-2.amazonaws.com/nsq_0.3.8_darwin.zip"
  sha256 "c1a5c2fb74867c098dc4991c20eaf7adffc2e1c4ef5962052e763cd9b64b78a1"

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
