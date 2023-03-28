{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";
    voidrice.url = "github:LukeSmithxyz/voidrice";
    voidrice.flake = false;
  };
  outputs = { self, nixpkgs, flake-utils, voidrice }:
    flake-utils.lib.eachDefaultSystem (system:
      with nixpkgs.legacyPackages.${system};
      rec {
        packages.maimpick = stdenv.mkDerivation rec {
          name = "maimpick";
          src = voidrice;
          nativeBuildInputs = [ makeWrapper ];
          buildInputs = [ coreutils dmenu maim xdotool xclip sl ];
          installPhase = ''
            mkdir -p $out/bin
            cp .local/bin/maimpick $out/bin
          '';
          postFixup = ''
            wrapProgram $out/bin/maimpick --set PATH ${lib.makeBinPath buildInputs }
          '';

        };
      }
    );
}

