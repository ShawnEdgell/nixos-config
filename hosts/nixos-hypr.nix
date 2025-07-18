{ config, pkgs, ... }:

{
  # Imports (hardware + modules)
  imports = [
    ./hardware-configuration.nix
    ../modules/audio.nix
    ../modules/games.nix
    ../modules/hyprland.nix
    ../modules/packages.nix
    ../modules/theme.nix
    ../modules/users.nix
  ];

  # Nix configuration
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    download-buffer-size = 33554432;
  };
  nixpkgs.config.allowUnfree = true;

  # Locale and timezone
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  # Networking
  networking = {
    hostName = "nixos-hypr";
    networkmanager.enable = true;
  };

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    grub.enable = false;
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;
  
  # NixOS version lock
  system.stateVersion = "25.05";
}
