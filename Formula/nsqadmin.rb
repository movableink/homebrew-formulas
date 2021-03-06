class Nsqadmin < Formula
  desc "Admin UI for NSQ"
  homepage "https://nsq.io"
  url "https://movableink-developer-binaries.s3-us-west-2.amazonaws.com/nsq_0.3.8_darwin.zip"
  sha256 "7ac121e06df0a08b63b646064ec6710ee70e9bde89272ef502ea9b5ae8039bc6"

  def install
    bin.install "#{buildpath}/nsqadmin"
  end

  plist_options :startup => true

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <true/>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{bin}/nsqadmin</string>
          <string>-lookupd-http-address=127.0.0.1:4161</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>#{var}</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/nsqadmin.log</string>
        <key>StandardOutPath</key>
        <string>#{var}/log/nsqadmin.log</string>
      </dict>
    </plist>
  EOS
  end

  test do
    system "true"
  end
end
