final: prev: let
  inherit (final) callPackage;
in {
  glibcLocales = callPackage ./package.nix {};
}
