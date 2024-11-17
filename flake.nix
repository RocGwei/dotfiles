{
  description = "My nix and dotfile manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations = {
        "roc@Mechrevo" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home-manager/roc-mechrevo.nix ];
        };
      };
    };
}

