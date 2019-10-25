class Nsqutils < Formula
  desc "Utilities for NSQ"
  homepage "https://nsq.io"
  url "https://movableink-developer-binaries.s3-us-west-2.amazonaws.com/nsq_0.3.8_darwin.zip"
  sha256 "92067e42af27b8a15e5f037e2cb9014858ec369140ce76b5aedd563bf1c2ccf8"

  def install
    bin.install Dir["#{buildpath}/bin/nsq_*"]
    bin.install "#{buildpath}/bin/to_nsq"
  end

  test do
    system "true"
  end
end
