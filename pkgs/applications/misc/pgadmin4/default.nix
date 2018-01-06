{ lib, pythonPackages, fetchurl,
  flask, flask_sqlalchemy, flask_script
}:

pythonPackages.buildPythonApplication rec {
  name = "${pname}-${version}";
  pname = "pgadmin4";
  version = "2.0";
  namePrefix = "";

  format = "wheel";

  src = fetchurl {
    url = "https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v2.0/pip/pgadmin4-2.0-py2.py3-none-any.whl";
    sha256 = "0b794p1d4hnv8ikb4v0ik2528l9sbgnqaf3iqvwr43nmpf031dln";
  };

  buildInputs = with pythonPackages; [ six Flask-Gravatar ];

  # propagatedBuildInputs = with pythonPackages; [
  #     dogpile_cache
  #     click
  #     requests
  #     characteristic
  #   ];

  meta = {
    homepage = https://www.pgadmin.org/;
    description = "Tools to make nix nicer to use";
    maintainers = [ lib.maintainers.madjar ];
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}

