with import <nixpkgs> {};
{ nixpkgs ? import (fetchgit {
    inherit (builtins.fromJSON (builtins.readFile ../../nixpkgs.json)) url rev sha256;
  }) {} }:
let
  haskellPackages = pkgs.haskell.packages.ghcjs;
  miso = haskellPackages.callPackage ((fetchgit {
    inherit (builtins.fromJSON (builtins.readFile ../../miso.json)) url rev sha256;
  }) + "/miso-ghcjs.nix") {};
  miso-style = haskellPackages.callPackage ../../miso-style.nix {
    miso = miso;
  };
in haskellPackages.callPackage ./hello-world.nix {
  miso = miso;
  miso-style = miso-style;
}
