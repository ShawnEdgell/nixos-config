{ config, pkgs, ... }:

{
  # Imports (hardware + modules)
  imports = [
    ./hardware-configuration.nix
    ../../modules/audio.nix
    ../../modules/games.nix
    ../../modules/hyprland.nix
    ../../modules/users.nix
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

  # System-level packages
  environment.systemPackages = with pkgs; [
    brightnessctl # Hardware control
    gvfs          # Virtual filesystem for file managers
    lxsession     # Provides the lxpolkit auth agent
    polkit        # The authentication daemon itself
    bluez         # Bluetooth daemon
    bluez-tools   # Bluetooth utilities
  ];

  # Enable tmpfs for /tmp to clear it on reboot
  boot.tmp.useTmpfs = true;

  # Enable GVFS and UDisks2 for Thunar Trash/Mount support
  services.gvfs.enable = true;
  services.udisks2.enable = true;

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
