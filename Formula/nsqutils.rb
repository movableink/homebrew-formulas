class Nsqutils < Formula
  desc "Utilities for NSQ"
  homepage "https://nsq.io"
  url "https://movableink-developer-binaries.s3-us-west-2.amazonaws.com/nsq_0.3.8_darwin.zip"
  sha256 "70fa07a13dd1d01039bca5ad03b72ee02eaf30da9e291d85e171d3e2a515284c"

  def install
    bin.install Dir["#{buildpath}/nsq_*"]
    bin.install "#{buildpath}/to_nsq"
  end

  test do
    system "true"
  end
end
