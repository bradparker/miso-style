with import <nixpkgs> {};
{ nixpkgs ? import (fetchgit {
    inherit (builtins.fromJSON (builtins.readFile ./nixpkgs.json)) url rev sha256;
  }) {},
  compiler ? "default" }:
let
  haskellPackages = if compiler == "default"
    then nixpkgs.haskellPackages
    else nixpkgs.haskell.packages.${compiler};
  misosrc = fetchgit {
    inherit (builtins.fromJSON (builtins.readFile ./miso.json)) url rev sha256;
  };
  miso = if compiler == "ghcjs" || compiler == "ghcjsHEAD"
    then haskellPackages.callPackage (misosrc + "/miso-ghcjs.nix") {}
    else haskellPackages.callPackage (misosrc + "/miso-ghc.nix") {};
in
  haskellPackages.callPackage ./miso-style.nix {
    miso = miso;
  }
