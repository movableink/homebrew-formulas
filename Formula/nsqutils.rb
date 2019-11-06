class Nsqutils < Formula
  desc "Utilities for NSQ"
  homepage "https://nsq.io"
  url "https://movableink-developer-binaries.s3-us-west-2.amazonaws.com/nsq_0.3.8_darwin.zip"
  sha256 "7ac121e06df0a08b63b646064ec6710ee70e9bde89272ef502ea9b5ae8039bc6"

  def install
    bin.install Dir["#{buildpath}/nsq_*"]
    bin.install "#{buildpath}/to_nsq"
  end

  test do
    system "true"
  end
end
