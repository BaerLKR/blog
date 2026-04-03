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
    rebar3 =
      pkgs.rebar3WithPlugins
      {
        plugins = with pkgs.beam28Packages; [pc];
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
    packages.${system} = rec {
      default = pkgs.stdenv.mkDerivation {
        name = "blog";
        version = "0.1.0";
        src = ./.;
        buildInput = [ssg];
        buildPhase = ''
          ${ssg}/bin/blog_lovirent_eu

        '';
        installPhase = ''
          mkdir -p $out
          mv dist/* $out
        '';
      };
      ssg = pkgs.buildGleamApplication {
        REBAR_CACHE_DIR = "$TMP/.rebar-cache";
        DEBUG = 1;
        rebar3Package = rebar3;
        buildInputs = [
          pkgs.esbuild
          pkgs.erlang_28
          rebar3
        ];
        src = ./.;
      };
    };
  };
}
