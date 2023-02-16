class Nsqadmin < Formula
  desc "Admin UI for NSQ"
  homepage "https://nsq.io"
  url "https://movableink-developer-binaries.s3-us-west-2.amazonaws.com/nsq_0.3.8_darwin.zip"
  sha256 "4df0a59b8e82c9502467b94df0ef5135457033751d9ff3239076539e1c6ea22e"

  def install
    bin.install "#{buildpath}/nsqadmin"
  end

  service do
    run [bin/"nsqadmin", "-lookupd-http-address=127.0.0.1:4161"]
    working_dir var
    log_path var/"log/nsqadmin.log"
    error_log_path var/"log/nsqadmin.log"
  end

  test do
    system "true"
  end
end
