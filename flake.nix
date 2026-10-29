{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default =
      with import nixpkgs { system = "x86_64-linux"; };
      let
        pname = "musescore";
        version = "4.7.6";

        src = fetchurl {
          url = "https://github.com/musescore/MuseScore/releases/download/v4.7.6/MuseScore-Studio-4.7.6.261022093-x86_64.AppImage";
          hash = "sha256:5fcbd1f292270eca5c3867d56b767c31a173a155216a415f5caee22553f8e7a6";
        };

        appimageContents = appimageTools.extract { inherit pname version src; };

      in
      appimageTools.wrapType2 {
        inherit pname version src;

        extraInstallCommands = ''
          install -m 444 -D ${appimageContents}/org.musescore.MuseScore4portable.desktop $out/share/applications/org.musescore.MuseScore4portable.desktop
          substituteInPlace $out/share/applications/org.musescore.MuseScore4portable.desktop \
                --replace-fail 'Exec=mscore4portable' 'Exec=musescore'
        '';
      };
  };
}
