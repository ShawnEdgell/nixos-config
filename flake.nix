{
  description = "NixOS system config with Hyprland, rose-pine, and Home Manager";

  inputs = {
    # Main NixOS package source (bleeding-edge)
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Home Manager pinned to match 25.05
    home-manager.url = "github:nix-community/home-manager";

    # Hyprland from official flake
    hyprland.url = "github:hyprwm/hyprland";

    # Rose Pine cursor theme
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "hyprland/hyprlang";
    };
  };

  outputs = { self, nixpkgs, hyprland, home-manager, rose-pine-hyprcursor, ... }: {
    nixosConfigurations.nixos-hypr = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit rose-pine-hyprcursor;
      };

      modules = [
        ./hosts/nixos-hypr.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.shawn = import ./home/home.nix;
        }
      ];
    };

    # Optional alias for convenience
    nixosConfigurations.default = self.nixosConfigurations.nixos-hypr;
  };

  # Optional CLI defaults when using `nix build/run`
  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
  };
}
