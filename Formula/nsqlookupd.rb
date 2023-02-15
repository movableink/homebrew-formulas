class Nsqlookupd < Formula
  desc "Topology daemon for NSQ"
  homepage "https://nsq.io"
  url "https://movableink-developer-binaries.s3-us-west-2.amazonaws.com/nsq_0.3.8_darwin.zip"
  sha256 "70fa07a13dd1d01039bca5ad03b72ee02eaf30da9e291d85e171d3e2a515284c"

  def install
    bin.install "#{buildpath}/nsqlookupd"
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
          <string>#{bin}/nsqlookupd</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>#{var}</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/nsqlookupd.log</string>
        <key>StandardOutPath</key>
        <string>#{var}/log/nsqlookupd.log</string>
      </dict>
    </plist>
  EOS
  end

  test do
    system "true"
  end
end
