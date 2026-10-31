{

  description = "nix flake config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixos-hardware,
      home-manager,
      disko,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations."ocean" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit nixos-hardware; };
        modules = [
          disko.nixosModules.disko
          ./hosts/ocean
        ];
      };

      homeConfigurations."xen" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/home.nix
        ];
      };
    };
}
