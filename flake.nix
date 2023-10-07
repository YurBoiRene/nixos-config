{
  description = "rene's nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config.allowUnfreePredicate = pkg:
        builtins.elem (nixpkgs.lib.getName pkg) [
          "steam-original"
          "steam-runtime"
          "steam"
          "steam-run"
        ];
    };
  in {
    nixosConfigurations.crab = nixpkgs.lib.nixosSystem {
      inherit pkgs system;
      specialArgs = inputs;
      modules = [
        ./configuration.nix
      ];
    };
  };
}
