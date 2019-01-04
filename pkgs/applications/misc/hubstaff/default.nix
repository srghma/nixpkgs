{ stdenv, fetchurl, unzip, makeWrapper, libX11, zlib, libSM, libICE
, libXext , freetype, libXrender, fontconfig, libXft, libXinerama
, libXfixes, libXScrnSaver, libnotify, glib , gtk3, libappindicator-gtk3
, curl, fetchFromGitHub }:

let

  data = builtins.fromJSON (builtins.readFile ./revision.json);

  inherit (data) version url sha256;

  rpath = stdenv.lib.makeLibraryPath
    [ libX11 zlib libSM libICE libXext freetype libXrender fontconfig libXft
      libXinerama stdenv.cc.cc.lib libnotify glib gtk3 libappindicator-gtk3
      curl libXfixes libXScrnSaver ];

  LOCALE_ARCHIVE_2_26 =
    let
      # A random Nixpkgs revision *before* the default glibc
      # was switched to version 2.27.x.
      oldpkgsSrc = fetchFromGitHub {
        owner = "nixos";
        repo = "nixpkgs";
        rev = "0252e6ca31c98182e841df494e6c9c4fb022c676";
        sha256 = "1sr5a11sb26rgs1hmlwv5bxynw2pl5w4h5ic0qv3p2ppcpmxwykz";
      };

      oldpkgs = import oldpkgsSrc {};
    in "${oldpkgs.glibc_2_26}/lib/locale/locale-archive";

in

stdenv.mkDerivation {
  name = "hubstaff-${version}";

  src = fetchurl { inherit url sha256; };

  nativeBuildInputs = [ unzip makeWrapper ];

  unpackCmd = ''
    # MojoSetups have a ZIP file at the end. ZIP’s magic string is
    # most often PK\x03\x04. This has worked for all past updates,
    # but feel free to come up with something more reasonable.
    dataZipOffset=$(grep --max-count=1 --byte-offset --only-matching --text ''$'PK\x03\x04' $curSrc | cut -d: -f1)
    dd bs=$dataZipOffset skip=1 if=$curSrc of=data.zip 2>/dev/null
    unzip -q data.zip "data/*"
    rm data.zip
  '';

  dontBuild = true;

  installPhase = ''
    # TODO: handle 32-bit arch?
    rm -r x86
    rm -r x86_64/lib64

    opt=$out/opt/hubstaff
    mkdir -p $out/bin $opt
    cp -r . $opt/

    for f in "$opt/x86_64/"*.bin.x86_64 ; do
      patchelf --set-interpreter $(cat ${stdenv.cc}/nix-support/dynamic-linker) $f
      wrapProgram $f --prefix LD_LIBRARY_PATH : ${rpath} --set LOCALE_ARCHIVE_2_26 ${LOCALE_ARCHIVE_2_26}
    done

    ln -s $opt/x86_64/HubstaffClient.bin.x86_64 $out/bin/HubstaffClient

    # Why is this needed? SEGV otherwise.
    ln -s $opt/data/resources $opt/x86_64/resources
  '';

  meta = with stdenv.lib; {
    description = "Time tracking software";
    homepage = https://hubstaff.com/;
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    maintainers = [ maintainers.michalrus ];
  };
}
