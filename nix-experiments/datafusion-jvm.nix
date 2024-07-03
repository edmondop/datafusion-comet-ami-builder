{ rustOut }:
let
  builder = { fetchFromGitHub, rustPlatform, runCommand }:

    rustPlatform.buildRustPackage rec {
      pname = "datafusion-comet";
      version = "0.1.1";


      src =
        let
          gitSource = fetchFromGitHub {
            owner = "apache";
            repo = "datafusion-comet";
            rev = version;
            hash = "sha256-FLjU9ShHy2oF8blzvXgcVOCJCjMjsLj+GdvURsYwTts=";
          };
        in
        runCommand "get-rust-code" { } ''cp -r ${gitSource}/core $out'';

      cargoLock = {
        lockFile = "${src}/Cargo.lock";
        allowBuiltinFetchGit = true;
      };
    };

  pkgs = import <nixpkgs> { };
in
pkgs.callPackage builder { fetchFromGitHub = pkgs.fetchFromGitHub; rustPlatform = pkgs.rustPlatform; runCommand = pkgs.runCommand; }
