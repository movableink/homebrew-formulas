class Postgresql < Formula
  desc "Object-relational database system"
  homepage "https://www.postgresql.org/"
  url "https://ftp.postgresql.org/pub/source/v10.6/postgresql-10.6.tar.bz2"
  sha256 "68a8276f08bda8fbefe562faaf8831cb20664a7a1d3ffdbbcc5b83e08637624b"

  bottle do
    root_url "https://movableink-homebrew-formulas.s3.amazonaws.com"
    rebuild 3
    sha256 mojave: "8bdc910e5cb9f0562721d2a2a0f7029f18c10647639dfc9843842dafa6498880"
  end

  depends_on "pkg-config" => :build
  depends_on "icu4c"
  depends_on "openssl"
  depends_on "readline"

  def install
    # avoid adding the SDK library directory to the linker search path
    ENV["XML2_CONFIG"] = "xml2-config --exec-prefix=/usr"

    ENV.prepend "LDFLAGS", "-L#{Formula["openssl"].opt_lib} -L#{Formula["readline"].opt_lib}"
    ENV.prepend "CPPFLAGS", "-I#{Formula["openssl"].opt_include} -I#{Formula["readline"].opt_include}"

    args = %W[
      --disable-debug
      --prefix=#{prefix}
      --datadir=#{HOMEBREW_PREFIX}/share/postgresql
      --libdir=#{HOMEBREW_PREFIX}/lib
      --sysconfdir=#{etc}
      --docdir=#{doc}
      --enable-thread-safety
      --with-bonjour
      --with-gssapi
      --with-icu
      --with-ldap
      --with-libxml
      --with-libxslt
      --with-openssl
      --with-pam
      --with-perl
      --with-uuid=e2fs
    ]

    # The CLT is required to build Tcl support on 10.7 and 10.8 because
    # tclConfig.sh is not part of the SDK
    if MacOS.version >= :mavericks || MacOS::CLT.installed?
      args << "--with-tcl"
      if File.exist?("#{MacOS.sdk_path}/System/Library/Frameworks/Tcl.framework/tclConfig.sh")
        args << "--with-tclconfig=#{MacOS.sdk_path}/System/Library/Frameworks/Tcl.framework"
      end
    end

    # As of Xcode/CLT 10.x the Perl headers were moved from /System
    # to inside the SDK, so we need to use `-iwithsysroot` instead
    # of `-I` to point to the correct location.
    # https://www.postgresql.org/message-id/153558865647.1483.573481613491501077%40wrigleys.postgresql.org
    ENV.prepend "LDFLAGS", "-L#{Formula["openssl"].opt_lib} -L#{Formula["readline"].opt_lib} -R#{lib}/postgresql"

    system "./configure", *args
    system "make"

    #  pkglibdir=#{lib}/postgresql
    dirs = %W[datadir=#{pkgshare} libdir=#{lib} pkglibdir=#{lib}/postgresql]

    # Temporarily disable building/installing the documentation.
    # Postgresql seems to "know" the build system has been altered and
    # tries to regenerate the documentation when using `install-world`.
    # This results in the build failing:
    #  `ERROR: `osx' is missing on your system.`
    # Attempting to fix that by adding a dependency on `open-sp` doesn't
    # work and the build errors out on generating the documentation, so
    # for now let's simply omit it so we can package Postgresql for Mojave.
    if DevelopmentTools.clang_build_version >= 1000
      system "make", "all"
      system "make", "-C", "contrib", "install", "all", *dirs
      system "make", "install", "all", *dirs
    else
      system "make", "install-world", *dirs
    end
  end

  def post_install
    (var/"log").mkpath
    (var/"postgres").mkpath
    unless File.exist? "#{var}/postgres/PG_VERSION"
      system "#{bin}/initdb", "#{var}/postgres"
    end
  end

  def caveats; <<~EOS
    To migrate existing data from a previous major version of PostgreSQL run:
      brew postgresql-upgrade-database
  EOS
  end

  plist_options :manual => "pg_ctl -D #{HOMEBREW_PREFIX}/var/postgres start"

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
        <string>#{opt_bin}/postgres</string>
        <string>-D</string>
        <string>#{var}/postgres</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>WorkingDirectory</key>
      <string>#{HOMEBREW_PREFIX}</string>
      <key>StandardOutPath</key>
      <string>#{var}/log/#{name}.log</string>
      <key>StandardErrorPath</key>
      <string>#{var}/log/#{name}.log</string>
    </dict>
    </plist>
  EOS
  end

  test do
    system "#{bin}/initdb", testpath/"test"
    assert_equal "#{HOMEBREW_PREFIX}/share/postgresql", shell_output("#{bin}/pg_config --sharedir").chomp
    assert_equal "#{HOMEBREW_PREFIX}/lib", shell_output("#{bin}/pg_config --libdir").chomp
    assert_equal "#{HOMEBREW_PREFIX}/lib", shell_output("#{bin}/pg_config --pkglibdir").chomp
  end
end
