class Nsqlookupd < Formula
  desc "Topology daemon for NSQ"
  homepage "https://nsq.io"
  url "https://movableink-developer-binaries.s3-us-west-2.amazonaws.com/nsq_0.3.8_darwin.zip"
  sha256 "4df0a59b8e82c9502467b94df0ef5135457033751d9ff3239076539e1c6ea22e"

  def install
    bin.install "#{buildpath}/nsqlookupd"
  end

  service do
    run [bin/"nsqlookupd"]
    working_dir var
    log_path var/"log/nsqlookupd.log"
    error_log_path var/"log/nsqlookupd.log"
  end

  test do
    system "true"
  end
end
