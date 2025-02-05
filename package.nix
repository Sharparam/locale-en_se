{
  lib,
  glibcLocales,
}:
glibcLocales.overrideAttrs (
  final: prev: {
    preBuild =
      ''
        echo 'HACK: Adding en_SE as a supported locale to glibc'
        cp -v ${lib.escapeShellArg "${./en_SE}"} ../glibc-2*/localedata/locales
        echo 'en_SE.UTF-8/UTF-8 \' >> ../glibc-2*/localedata/SUPPORTED
      ''
      + prev.preBuild;
  }
)
