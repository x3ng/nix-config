{

  description = "nix flake config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgsWithUnfree = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations."ocean" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/ocean
        ];
      };

      homeConfigurations."xen" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsWithUnfree;
        modules = [ 
          ./home/home.nix 
        ];
      };
    };
}
