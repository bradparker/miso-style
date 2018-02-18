{ pkgs ? import ((import <nixpkgs> {}).fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "1c988f97e9910665d258a8b83437178349b4e624";
    sha256 = "10vmr1r172bgv5wqpram08pd657ygdcpm1gr88sdj1caqwxbp5ac";
  }){}
}:
let
  haskellPackages = pkgs.haskell.packages.ghcjs;
  miso = import (pkgs.fetchFromGitHub {
    owner = "dmjio";
    repo = "miso";
    sha256 = "18jhr1ihf0vwwvp134j24isvzq699x5iy7l9ihrah760zmcxi7d2";
    rev = "e3d3d874337a4a44adc4b6bdb8b18d907c6c1e34";
  }) {};
  miso-style = haskellPackages.callPackage ../../miso-style.nix {
    miso = miso.miso-ghcjs;
  };
in haskellPackages.callPackage ./hello-world.nix {
  miso = miso.miso-ghcjs;
  miso-style = miso-style;
}
