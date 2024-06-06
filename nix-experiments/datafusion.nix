let pkgs = import <nixpkgs> { };
in
{
  jdk11 = pkgs.callPackage ./datafusion-builder.nix {
    jdk = pkgs.jdk11;
    sparkVersion = "3.4";
    rustc = pkgs.rustc;
    cargo = pkgs.cargo;
  };
  jdk13 = pkgs.callPackage ./datafusion-builder.nix {
    jdk = pkgs.jdk13;
    sparkVersion = "3.4";
    rustc = pkgs.rustc;
    cargo = pkgs.cargo;
  };
}
