{ mkDerivation, base, containers, dlist, hashable, hspec, miso
, stdenv, transformers
}:
mkDerivation {
  pname = "miso-style";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [
    base containers dlist hashable miso transformers
  ];
  testHaskellDepends = [ base hspec miso ];
  description = "CSS in Haskell for the Miso framework";
  license = stdenv.lib.licenses.bsd3;
}
