{
  description = "Flake for the MicroHs Haskell compiler";
  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05"; };

  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      nixPkgsFor = system: nixpkgs.legacyPackages.${system};
    in rec {
      packages = forAllSystems (system: rec {
        microhs = (nixPkgsFor system).callPackage ./microhs.nix { };
        default = microhs;
      });
      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${packages.${system}.microhs}/bin/mhs";
        };
      });
    };
}
