{ lib, stdenv, fetchFromGitHub, cmake
  # passthru.tests
, tmux
, fcft
, arrow-cpp
}:

stdenv.mkDerivation rec {
  pname = "utf8proc";
  version = "2.9.0";

  src = fetchFromGitHub {
    owner = "JuliaStrings";
    repo = pname;
    rev = "3de4596fbe28956855df2ecb3c11c0bbc3535838";
    sha256 = "sha256-DNnrKLwks3hP83K56Yjh9P3cVbivzssblKIx4M/RKqw=";
  };

  nativeBuildInputs = [ cmake ];

  cmakeFlags = [
    "-DBUILD_SHARED_LIBS=ON"
    "-DUTF8PROC_ENABLE_TESTING=ON"
  ];

  doCheck = true;

  passthru.tests = {
    inherit fcft tmux arrow-cpp;
  };

  meta = with lib; {
    description = "Clean C library for processing UTF-8 Unicode data";
    homepage = "https://juliastrings.github.io/utf8proc/";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [ maintainers.ftrvxmtrx maintainers.sternenseemann ];
  };
}
