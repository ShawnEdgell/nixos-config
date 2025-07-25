{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/audio.nix
    ../../modules/games.nix
    ../../modules/hyprland.nix
    ../../modules/users.nix
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    download-buffer-size = 33554432;
  };
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  environment.systemPackages = with pkgs; [
    brightnessctl
    gvfs
    lxsession
    polkit
    bluez
    bluez-tools
  ];

  boot.tmp.useTmpfs = true;

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  networking = {
    hostName = "nixos-hypr";
    networkmanager.enable = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    grub.enable = false;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  system.stateVersion = "25.05";
}
