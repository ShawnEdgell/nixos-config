# /etc/nixos/hosts/laptop/configuration.nix
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # System Settings & Localization
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";
  boot.tmp.useTmpfs = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # User & Login Management
  users.users.shawn = {
    isNormalUser = true;
    description = "shawn";
    shell = pkgs.bashInteractive;
    extraGroups = [ "wheel" "networkmanager" "input" "video" ];
  };
  services.getty.autologinUser = "shawn";

  # Networking
  networking.hostName = "nixos-hypr";
  networking.networkmanager.enable = true;

  # Audio Service (Pipewire)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Wayland & Graphics Environment
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [ vulkan-loader vulkan-tools vulkan-validation-layers ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ vulkan-loader ];
  };
  environment.sessionVariables = {
    # NVIDIA & Wayland Variables formerly in hyprland.conf
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_FROM_GLVND = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER = "vulkan";
    WLR_DRM_NO_ATOMIC = "1";
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];

  # Gaming Services
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.gamemode.enable = true;

  # System Services
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.power-profiles-daemon.enable = true;

  # System-Wide Packages
  environment.systemPackages = with pkgs; [
    brightnessctl
    gvfs
    lxsession
    polkit
    bluez
    bluez-tools
  ];

  # System State Version
  system.stateVersion = "25.05";
}