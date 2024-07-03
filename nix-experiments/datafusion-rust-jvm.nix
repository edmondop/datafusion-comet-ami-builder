{ pkgs ? import <nixpkgs> { } }:
let 
  rustBuild = import ./datafusion-rust.nix ;
  javaBuild = import ./datafusion-jvm.nix { rustOut = rustBuild.out; } ;
in
  javaBuild.out # # jar