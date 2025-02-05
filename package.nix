{
  lib,
  glibcLocales,
  ...
} @ args:
(
  glibcLocales.override (lib.removeAttrs args ["glibcLocales"])
)
.overrideAttrs (
  final: prev: {
    preBuild =
      ''
        echo 'HACK: Adding en_SE as a supported locale to glibc'
        set -x
        dest=../glibc-2*/localedata/locales
        cp -v ${lib.escapeShellArg "${./en_SE}"} $dest/locales/en_SE
        echo 'en_SE.UTF-8/UTF-8 \' >> ../glibc-2*/localedata/SUPPORTED
        set +x
      ''
      + prev.preBuild;
  }
)
