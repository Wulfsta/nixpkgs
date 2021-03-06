{ lib, stdenv, fetchurl, pkgconfig, gettext, libtool, libxml2, libcanberra-gtk3, gtk3, mate, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "mate-media";
  version = "1.24.1";

  src = fetchurl {
    url = "https://pub.mate-desktop.org/releases/${lib.versions.majorMinor version}/${pname}-${version}.tar.xz";
    sha256 = "118i4w2i2g3hfgbfn3hjzjkfq8vjj6049r7my3vna9js23b7ab92";
  };

  buildInputs = [
    libxml2
    libcanberra-gtk3
    gtk3
    mate.libmatemixer
    mate.mate-panel
    mate.mate-desktop
  ];

  nativeBuildInputs = [
    pkgconfig
    gettext
    libtool
    wrapGAppsHook
  ];

  enableParallelBuilding = true;

  meta = with lib; {
    description = "Media tools for MATE";
    homepage = "https://mate-desktop.org";
    license = licenses.gpl3;
    platforms = platforms.unix;
    maintainers = [ maintainers.romildo maintainers.chpatrick ];
  };
}
