{
  description = "NixOS system config with Hyprland, rose-pine, and Home Manager";

  inputs = {
    # Nixpkgs unstable for latest packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager (same nixpkgs source as system)
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland window manager
    hyprland.url = "github:hyprwm/hyprland";

    # Rose Pine Hyprcursor theme
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "hyprland/hyprlang";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, rose-pine-hyprcursor, ... }@inputs: {
    nixosConfigurations = {
      # Laptop system
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };

        modules = [
          ./hosts/laptop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; };

            home-manager.users.shawn = {
              imports = [ ./home/home.nix ];
            };
          }
        ];
      };

      # Default target if none specified
      default = self.nixosConfigurations.laptop;
    };
  };

  nixConfig.experimental-features = [ "nix-command" "flakes" ];
}