{
  description = "Opinionated en_SE locale";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    inherit (nixpkgs) lib;
    supportedSystems = lib.systems.flakeExposed;
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
  in {
    formatter = forAllSystems (system: let
      nixpkgs' = nixpkgs.legacyPackages.${system};
    in
      nixpkgs'.writeShellScriptBin "formatter" ''
        ${nixpkgs'.alejandra}/bin/alejandra .
      '');

    packages = forAllSystems (system: let
      nixpkgs' = nixpkgs.legacyPackages.${system};
      packages = self.packages.${system};
    in {
      default = packages.glibcLocales;
      glibcLocales = nixpkgs'.callPackage ./package.nix {};
    });

    # probably not a good idea to use this but im not your mom
    overlays.default = import ./overlay.nix;

    nixosModules.default = import ./module.nix;
  };
}
