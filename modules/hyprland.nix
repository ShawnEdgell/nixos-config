{ config, pkgs, ... }:

{
  # Enable Hyprland and XWayland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable xdg-desktop-portal with Hyprland backend
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # Auto-login for TTY
  services.getty.autologinUser = "shawn";
}
