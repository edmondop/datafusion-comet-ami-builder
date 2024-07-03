let pkgs = import <nixpkgs> { };
in
{
  jdk11 = pkgs.callPackage ./datafusion-builder.nix {
    jdk = pkgs.jdk11;
    sparkVersion = "3.4";
    rustc = pkgs.rustc;
    cargo = pkgs.cargo;
  };
  jdk17 = pkgs.callPackage ./datafusion-builder.nix {
    jdk = pkgs.jdk17;
    sparkVersion = "3.4";
    rustc = pkgs.rustc;
    cargo = pkgs.cargo;
  };
}
