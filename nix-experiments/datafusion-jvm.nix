{ rustOut }:
let
  builder = { fetchFromGitHub, rustPlatform, runCommand }:

    rustPlatform.buildRustPackage rec {
      pname = "datafusion-comet";
      version = "68efa57740534990734062e2b18df694f46572e6";


      src =
        let
          gitSource = fetchFromGitHub {
            owner = "apache";
            repo = "datafusion-comet";
            rev = version;
            hash = "sha256-tOsPAxvNuOKh+dznhHHWKP3ejF1ZvvZt70qKJJwrFdw=";
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
