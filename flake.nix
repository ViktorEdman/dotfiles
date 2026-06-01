{
  description = "Viktor's NixOS and Home Manager configs";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
    }:
    let
      system = "x86_64-linux";
      username = "viktor";
      hostname = "nixos";
      overlay = final: prev: {
        my-nvim = final.callPackage ./pkgs/nvim { };
      };
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ overlay ];
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in
    {
      overlays.default = overlay;
      packages.${system} = {
        inherit (pkgs) my-nvim;
      };
      homeConfigurations."${username}@${hostname}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit
            self
            inputs
            username
            hostname
            ;
        };
        modules = [
          ./home/viktor
        ];
      };

      nixosConfigurations.${hostname} = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit
            self
            inputs
            username
            hostname
            ;

        };
        modules = [
          ./hosts/nixos/base

          home-manager.nixosModules.home-manager
          {
            home-manager.userGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home.manager.extraSpecialArgs = {
              inherit
                self
                inputs
                username
                hostname
                ;
            };
            home-manager.users.viktor = import ./home/viktor;
          }
        ];
      };
    };
}
