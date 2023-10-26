{
  description = "rene's nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
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
          "code"
          "vscode"
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

    homeConfigurations."rene@crab" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs; 
      extraSpecialArgs = inputs;
      modules = [
        ./user/home.nix
      ];
    };
  };
}
