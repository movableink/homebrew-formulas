class Nsqadmin < Formula
  desc "Admin UI for NSQ"
  homepage "https://nsq.io"
  url "https://movableink-developer-binaries.s3-us-west-2.amazonaws.com/nsq_0.3.8_darwin.zip"
  sha256 "c1a5c2fb74867c098dc4991c20eaf7adffc2e1c4ef5962052e763cd9b64b78a1"

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
