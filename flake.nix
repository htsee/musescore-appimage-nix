{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default =
      with import nixpkgs { system = "x86_64-linux"; };
      let
        pname = "musescore";
        version = "4.7.4";

        src = fetchurl {
          url = "https://github.com/musescore/MuseScore/releases/download/v4.7.4/MuseScore-Studio-4.7.4.260706075-x86_64.AppImage";
          hash = "sha256:9233ed1b87d3e6b45722278f3c286dcd41e83da778bd0f80a1dd04949696ad93";
        };
      in
      appimageTools.wrapType2 { inherit pname version src; };
  };
}
