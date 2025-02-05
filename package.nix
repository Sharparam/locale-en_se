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
    postPatch =
      prev.postPatch
      + ''
        echo 'HACK: Adding en_SE as a supported locale to glibc'
        set -x
        dest=../glibc-2*/localedata/locales
        cp -v ${lib.escapeShellArg "${./en_SE}"} localedata/locales/en_SE
        echo 'en_SE.UTF-8/UTF-8 \' >> localedata/SUPPORTED
        set +x
      '';
  }
)
