{stdenv, lib, fetchFromGitHub}:
stdenv.mkDerivation {
  pname = "microhs";
  version = "2024-09-29";
  src = fetchFromGitHub {
    owner = "augustss";
    repo = "MicroHs";
    rev = "efdc17331aba84555fe9931748138aced8a45a63";
    hash = "sha256-ftvc6WBHvvlQCL9NsnX81V19SXKhHKXaeVfw8I5tFyo=";
  };
  preBuild = ''
    substituteInPlace Makefile --replace-fail "echo 'module" "echo -e 'module"
    substituteInPlace Makefile --replace-fail "MCABAL=\$(HOME)/.mcabal" "MCABAL=\$(out)"
  '';
}
