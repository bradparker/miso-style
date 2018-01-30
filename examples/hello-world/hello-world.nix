{ mkDerivation, base, containers, miso, miso-style, stdenv }:
mkDerivation {
  pname = "hello-world";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base containers miso miso-style ];
  description = "Super simple little app";
  license = stdenv.lib.licenses.bsd3;
}
