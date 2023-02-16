class Nsqd < Formula
  desc "Message queueing daemon for NSQ"
  homepage "https://nsq.io"
  url "https://movableink-developer-binaries.s3-us-west-2.amazonaws.com/nsq_0.3.8_darwin.zip"
  sha256 "4df0a59b8e82c9502467b94df0ef5135457033751d9ff3239076539e1c6ea22e"

  def install
    bin.install "#{buildpath}/nsqd"

    mkdir "#{var}/nsq"
  end

  service do
    run [
      bin/"nsqd",
      "-data-path=#{var}/nsq",
      "-broadcast-address=localhost",
      "-lookupd-tcp-address=127.0.0.1:4160"
    ]
    working_dir var
    log_path var/"log/nsqd.log"
    error_log_path var/"log/nsqd.log"
  end

  test do
    system "true"
  end
end
