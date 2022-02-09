{ lib, stdenv, fetchzip, fetchFromGitHub, fetchpatch, fetchurl, xmlstarlet, makeWrapper, ant, jdk, rsync, javaPackages, libXxf86vm, gsettings-desktop-schemas }:

stdenv.mkDerivation rec {
  pname = "openbcigui";
  version = "v5.0.9";

  src = fetchzip {
    url = "https://github.com/OpenBCI/OpenBCI_GUI/releases/download/v5.0.9/openbcigui_v5.0.9_2021-11-06_00-16-07_linux64.zip";
    sha256 = "1lv7g9708dk367ih9svm5simpkacsmy2zr8zd3kg9w9q12fv490w";
  };

  nativeBuildInputs = [ rsync makeWrapper ];
  buildInputs = [ jdk ];

  installPhase = ''
    mkdir -p $out
    cp -R $src $out/${pname}
    chmod +w -R $out/${pname}

    ls -al $out
    ls -al $out/${pname}

    rm -rfd $out/${pname}/java
    ln -s ${jdk} $out/${pname}/java

    makeWrapper $out/${pname}/OpenBCI_GUI      $out/bin/openbcigui \
        --prefix XDG_DATA_DIRS : ${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name} \
        --prefix _JAVA_OPTIONS " " -Dawt.useSystemAAFontSettings=lcd \
        --prefix LD_LIBRARY_PATH : ${libXxf86vm}/lib
  '';

  meta = with lib; {
    description = "A cross platform application for the OpenBCI Cyton and Ganglion.";
    homepage = "https://github.com/OpenBCI/OpenBCI_GUI";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
  };
}
