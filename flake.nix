# ./flake.nix
{
  description = "NixOS system config with Hyprland, rose-pine, and Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/hyprland";
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "hyprland/hyprlang";
    };
  };

  outputs = { self, nixpkgs, hyprland, home-manager, ... }@inputs: { # Changed to use @inputs
    nixosConfigurations.nixos-hypr = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      # Pass all flake inputs to NixOS modules
      specialArgs = { inherit inputs; };

      modules = [
        ./hosts/nixos-hypr.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";

          # Pass all flake inputs to Home Manager modules
          home-manager.extraSpecialArgs = { inherit inputs; };

          home-manager.users.shawn = {
            imports = [ ./home/home.nix ];
          };
        }
      ];
    };

    nixosConfigurations.default = self.nixosConfigurations.nixos-hypr;
  };

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
  };
}