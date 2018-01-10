class Qtwebkit < Formula
  desc "Full-featured qt port of the WebKit rendering engine"
  homepage "https://github.com/annulen/webkit"
  url "https://github.com/annulen/webkit/releases/download/qtwebkit-tp4/qtwebkit-tp4.tar.xz"
  sha256 "35fcf7e04742b040a072245d79f36d1486e63345a69f53e09408c6564d3bcf27"
  revision 1
  version "HEAD-3777b4f"
  head "https://github.com/annulen/webkit.git", :branch => "qtwebkit-stable"

  depends_on "cmake" => :build
  depends_on "ninja" => [:build, :optional]
  depends_on "movableink/formulas/qt"
  depends_on "libjpeg"
  depends_on "libpng"
  depends_on "fontconfig"
  depends_on "webp"

  bottle do
    root_url "https://movableink-homebrew-formulas.s3.amazonaws.com"
    cellar :any
    rebuild 1
    sha256 "a5115e00e1750c6c78393a883167beb426d40872017de3550a9e7759e41567f0" => :high_sierra
  end

  patch do
    url "https://gist.githubusercontent.com/mnutt/8a0ae505e13ee89d571036d67a56bf9e/raw/c95d2777b138a11af330fac83c03bede276169de/mac_framework_includes.patch"
    sha256 "6933e62d45bbc6cfc38a7ec376637f300226768c94c91b268555b843cf429c8e"
  end

  def install
    qt5 = Formula["qt5"]

    extra_args = %W[
      -DPORT=Qt
      -DCMAKE_PREFIX_PATH=#{qt5.installed_prefix}
    ]

    mkdir "build" do
      system "cmake", "..", *(std_cmake_args + extra_args)
      system "make", "install"
    end
  end

  # test do
  #   (testpath/"test.c").write <<-EOS.undent
  #     #include <webkit2/webkit2.h>

  #     int main(int argc, char *argv[]) {
  #       fprintf(stdout, "%d.%d.%d\\n",
  #         webkit_get_major_version(),
  #         webkit_get_minor_version(),
  #         webkit_get_micro_version());
  #       return 0;
  #     }
  #   EOS
  #   ENV.libxml2
  #   atk = Formula["atk"]
  #   cairo = Formula["cairo"]
  #   fontconfig = Formula["fontconfig"]
  #   freetype = Formula["freetype"]
  #   gdk_pixbuf = Formula["gdk-pixbuf"]
  #   gettext = Formula["gettext"]
  #   glib = Formula["glib"]
  #   gtkx3 = Formula["gtk+3"]
  #   harfbuzz = Formula["harfbuzz"]
  #   libepoxy = Formula["libepoxy"]
  #   libpng = Formula["libpng"]
  #   libsoup = Formula["libsoup"]
  #   pango = Formula["pango"]
  #   pixman = Formula["pixman"]
  #   flags = %W[
  #     -I#{atk.opt_include}/atk-1.0
  #     -I#{cairo.opt_include}/cairo
  #     -I#{fontconfig.opt_include}
  #     -I#{freetype.opt_include}/freetype2
  #     -I#{gdk_pixbuf.opt_include}/gdk-pixbuf-2.0
  #     -I#{gettext.opt_include}
  #     -I#{glib.opt_include}/gio-unix-2.0/
  #     -I#{glib.opt_include}/glib-2.0
  #     -I#{glib.opt_lib}/glib-2.0/include
  #     -I#{gtkx3.opt_include}/gtk-3.0
  #     -I#{harfbuzz.opt_include}/harfbuzz
  #     -I#{include}/webkitgtk-4.0
  #     -I#{libepoxy.opt_include}
  #     -I#{libpng.opt_include}/libpng16
  #     -I#{libsoup.opt_include}/libsoup-2.4
  #     -I#{pango.opt_include}/pango-1.0
  #     -I#{pixman.opt_include}/pixman-1
  #     -D_REENTRANT
  #     -L#{atk.opt_lib}
  #     -L#{cairo.opt_lib}
  #     -L#{gdk_pixbuf.opt_lib}
  #     -L#{gettext.opt_lib}
  #     -L#{glib.opt_lib}
  #     -L#{gtkx3.opt_lib}
  #     -L#{libsoup.opt_lib}
  #     -L#{lib}
  #     -L#{pango.opt_lib}
  #     -latk-1.0
  #     -lcairo
  #     -lcairo-gobject
  #     -lgdk-3
  #     -lgdk_pixbuf-2.0
  #     -lgio-2.0
  #     -lglib-2.0
  #     -lgobject-2.0
  #     -lgtk-3
  #     -lintl
  #     -ljavascriptcoregtk-4.0
  #     -lpango-1.0
  #     -lpangocairo-1.0
  #     -lsoup-2.4
  #     -lwebkit2gtk-4.0
  #   ]
  #   system ENV.cc, "test.c", "-o", "test", *flags
  #   assert_match version.to_s, shell_output("./test")
  # end
end
