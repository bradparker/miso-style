{ mkDerivation, base, miso, miso-style, random, stdenv
, transformers, vector
}:
mkDerivation {
  pname = "benchmarks";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base miso miso-style random transformers vector
  ];
  description = "Benching miso-style";
  license = stdenv.lib.licenses.bsd3;
}
