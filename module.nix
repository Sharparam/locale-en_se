{
  config,
  lib,
  pkgs,
  ...
}: {
  config = let
    glibcLocales = pkgs.callPackage ./package.nix {};
  in {
    i18n = {
      glibcLocales = glibcLocales.override {
        allLocales = lib.any (x: x == "all") config.i18n.supportedLocales;
        locales = config.i18n.supportedLocales;
      };
    };
  };
}
