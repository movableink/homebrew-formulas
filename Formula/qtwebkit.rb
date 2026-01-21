class Qtwebkit < Formula
  desc "Full-featured qt port of the WebKit rendering engine"
  homepage "https://github.com/movableink/webkit"
  url "https://github.com/movableink/webkit/releases/download/2025-06-10/qtwebkit-2025-06-10-src.tar.xz"
  sha256 "83fd70b90f12e98cf10e52cca90d0234a3b088a5c46bd498b8d096dfe82e8811"
  revision 1
  version "2025-06-10"
  head "https://github.com/movableink/webkit.git", :branch => "master"

  depends_on "cmake" => :build
  depends_on "ninja" => [:build, :optional]
  depends_on "movableink/formulas/qtbase"
  depends_on "libjpeg"
  depends_on "libpng"
  depends_on "fontconfig"
  depends_on "webp"

  bottle do
    root_url "https://movableink-homebrew-formulas.s3.amazonaws.com"
    sha256 cellar: :any, arm64_sequoia: "1ed46d05db4492b86e9c92b8f116c970bd8e4e582321de1bc04d1a34b9c1e6f4"
  end

  def install
    qtbase = Formula["movableink/formulas/qtbase"]

    extra_args = %W[
      -DPORT=Qt
      -DENABLE_WEBKIT=OFF
      -DENABLE_GEOLOCATION=OFF
      -DENABLE_DEVICE_ORIENTATION=OFF
      -DENABLE_OPENGL=OFF
      -DDEVELOPER_MODE_FATAL_WARNINGS=OFF
      -DENABLE_INSPECTOR_UI=ON
      -DENABLE_EXPERIMENTAL_FEATURES=ON
      -DENABLE_WEB_CODECS=ON
      -DCMAKE_PREFIX_PATH=#{qtbase.opt_prefix}
      -DCMAKE_FRAMEWORK_PATH=#{qtbase.opt_lib}
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
