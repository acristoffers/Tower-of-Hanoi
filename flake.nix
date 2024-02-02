{
  description = "Tower of Hanoi";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

    flake-utils.url = github:numtide/flake-utils;

    gitignore.url = github:hercules-ci/gitignore.nix;
    gitignore.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, flake-utils, gitignore }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (gitignore.lib) gitignoreSource;
      in
      rec {
        packages.tower-of-hanoi = pkgs.flutter.buildFlutterApplication rec {
          pname = "tower-of-hanoi";
          version = "1.0.0";
          src = gitignoreSource ./.;
          autoPubspecLock = ./pubspec.lock;
        };
        packages.default = packages.tower-of-hanoi;
        devShell = with pkgs; mkShell rec {
          buildInputs = [ flutter ];
          nativeBuildInputs = [ busybox ];
        };
        apps = rec {
          tower-of-hanoi = {
            type = "app";
            program = "${packages.default}/bin/tower_of_hanoi";
          };
          default = tower-of-hanoi;
        };
      });
}
