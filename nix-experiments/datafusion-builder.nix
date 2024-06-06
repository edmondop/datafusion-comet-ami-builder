{ jdk, rustc, cargo, sparkVersion }:
let
  pkgs = import <nixpkgs> { };
in
pkgs.stdenv.mkDerivation rec {
  pname = "apache-spark-comet-datafusion";
  version = "a668a86";

  nativeBuildInputs = [
    rustc
    jdk
    cargo
    pkgs.maven
    pkgs.gnumake
    pkgs.gcc
  ];

  src = pkgs.fetchFromGitHub {
    owner = "apache";
    repo = "datafusion-comet";
    rev = version;
    hash = "sha256-FLjU9ShHy2oF8blzvXgcVOCJCjMjsLj+GdvURsYwTts=";
  };

  buildPhase = ''
    make release PROFILES="-Pspark-${sparkVersion}"
  '';

  installPhase = ''
    mkdir -p $out
    cp spark/target/comet-spark-*.jar $out
  '';
}
