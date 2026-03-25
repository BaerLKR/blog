{
  description = "my blog";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-gleam.url = "git+https://gitlab.olaf.one/pacman/nix-gleam.git";
  };
  outputs = {
    nixpkgs,
    nix-gleam,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        nix-gleam.overlays.default
      ];
    };
  in {
    devShells.${system}.default = pkgs.mkShell {
      name = "gleam";
      buildInputs = with pkgs; [
        erlang
        gleam
        inotify-tools
        rebar3
      ];
    };
    packages.${system}.default = pkgs.buildGleamApplication {
      src = ./.;
    };
  };
}
