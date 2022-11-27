{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    voidrice.url = "github:LukeSmithxyz/voidrice";
    voidrice.flake = false;
  };
  outputs = { self, nixpkgs, flake-utils, voidrice }:
    flake-utils.lib.eachDefaultSystem (system:
      with nixpkgs.legacyPackages.${system};
      rec {
        buildInputs = [ coreutils dmenu maim xdotool xclip sl ];
        packages.maimpick = stdenv.mkDerivation rec {
          name = "maimpick";
          src = voidrice;
          nativeBuildInputs = [ makeWrapper ];
          installPhase = ''
            mkdir -p $out/bin
            cp .local/bin/maimpick $out/bin
            wrapProgram $out/bin/maimpick --set PATH ${lib.makeBinPath buildInputs }
          '';

        };
      }
    );
}

