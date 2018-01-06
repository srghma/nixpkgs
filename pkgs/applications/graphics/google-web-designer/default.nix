{ stdenv
, dpkg
, fetchurl
, unzip
}:

stdenv.mkDerivation rec {
  name = "google-web-designer-${version}";
  version = "0.1";

  src = fetchurl {
    url = "https://dl.google.com/linux/direct/google-webdesigner_current_amd64.deb";
    sha256 = "1gv3sz98ifwj3111qkiwczn0db3jw2ijswafhc9xap2rljsf2673";
  };

  buildInputs = [ dpkg ];

  unpackPhase = ''
    dpkg-deb -x ${src} ./
  '';

  doConfigure = false;

  # installPhase = ''
  #   mkdir -p $out
  #   cd ./usr/lib/unifi
  #   cp -ar dl lib webapps $out
  # '';

  meta = with stdenv.lib; {
    homepage = http://www.ubnt.com/;
    description = "Controller for Ubiquiti UniFi accesspoints";
    license = licenses.unfree;
    platforms = platforms.unix;
    maintainers = with maintainers; [ wkennington ];
  };
}
