{
  description = "Opinionated en_SE locale";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs }:
  let
    version = "1.0.0";
    supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
  in {
    packages = forAllSystems (system: let pkgs = import nixpkgs { inherit system; }; in {
      locale-en_se = pkgs.stdenv.mkDerivation {
        pname = "locale-en_se";
        inherit version;

        src = ./.;

        installPhase = ''
          runHook preInstall
          mkdir -p "$out/share/i18n/locales"
          cp -v "$src/en_SE" "$out/share/i18n/locales"
          runHook postInstall
        '';
      };
    });

    defaultPackage = forAllSystems (system: self.packages.${system}.locale-en_se);
  };
}
