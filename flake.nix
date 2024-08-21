{
  inputs = {
    utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages.default = pkgs.stdenvNoCC.mkDerivation rec {
          src = ./.;
          pname = "lovis_blog";
          version = "0.1.0";
          buildPhase = with pkgs; ''
            ${hugo}/bin/hugo
          '';
          installPhase = with pkgs; ''
            mkdir -p $out
            cp -r public/* $out
          '';
        };
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            hugo
          ];
        };
      }
    );
}
