{ stdenv, fetchFromGitLab, pkgconfig, meson, ninja, gusb, pixman, glib, nss
, gobject-introspection, coreutils, gtk-doc, docbook_xsl, docbook_xml_dtd_43 }:

stdenv.mkDerivation rec {
  pname = "libfprint";
  version = "1.90.1";

  src = fetchFromGitLab {
    domain = "gitlab.freedesktop.org";
    owner = "libfprint";
    repo = "libfprint";
    rev = "66c9e4a829a06a25d8b6160cdfbad1d47ef5b81a";
    sha256 = "0fdaak7qjr9b4482g7fhhqpyfdqpxq5kpmyzkp7f5i7qq2ynb78a";
  };

  nativeBuildInputs = [
    pkgconfig
    meson
    ninja
    gtk-doc
    docbook_xsl
    docbook_xml_dtd_43
    gobject-introspection
  ];

  buildInputs = [ gusb pixman glib nss ];

  mesonFlags = [
    "-Dudev_rules_dir=${placeholder "out"}/lib/udev/rules.d"
    "-Dx11-examples=false"
  ];

  postPatch = ''
    substituteInPlace libfprint/meson.build \
      --replace /bin/echo ${coreutils}/bin/echo
  '';

  meta = with stdenv.lib; {
    homepage = "https://fprint.freedesktop.org/";
    description =
      "A library designed to make it easy to add support for consumer fingerprint readers";
    license = licenses.lgpl21;
    platforms = platforms.linux;
    maintainers = with maintainers; [ abbradar elyhaka ];
  };
}
