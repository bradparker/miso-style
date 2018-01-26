{ mkDerivation
, base
, containers
, ghcjs-base
, hashable
, miso
, pretty
, stdenv
, transformers
, lens
}:
mkDerivation {
  pname = "miso-style";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends =
    [ base
      containers
      hashable
      miso
      pretty
      transformers
      lens
    ];
  executableHaskellDepends = [ base miso ];
  description = "CSS in Haskell";
  license = stdenv.lib.licenses.bsd3;
}
