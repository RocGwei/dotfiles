{
  description = "My nix and dotfile manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      distro-grub-themes,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        "Dell-G3" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit pkgs system distro-grub-themes;
          };
          modules = [
            ./host/Dell-G3/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        "roc@Dell-G3" = home-manager.lib.homeManagerConfiguration {
          #extraSpecialArgs = {
          inherit pkgs;
          #};
          modules = [
            ./home-manager/roc-dell-g3.nix
          ];
        };
      };

      homeConfigurations = {
        "roc@Mechrevo" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {
            inherit pkgs;
          };
          modules = [
            ./home-manager/roc-mechrevo.nix
          ];
        };
      };
    };
}
