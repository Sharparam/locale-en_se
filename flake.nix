{
  description = "Opinionated en_SE locale";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs }:
  let
    supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
  in {
    packages = forAllSystems (system: let
      nixpkgs' = nixpkgs.legacyPackages.${system};
      packages = self.packages.${system};
    in {
      default = packages.glibcLocales;
      glibcLocales = nixpkgs'.callPackage ./package.nix {};
    });

    # probably not a good idea to use this but im not your mom
    overlays.default = import ./overlay.nix;
  };
}
