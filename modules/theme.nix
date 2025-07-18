{ config, pkgs, rose-pine-hyprcursor, ... }:

{
  programs.dconf.enable = true;

  # Theme-related environment variables
  environment.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
    XCURSOR_THEME = "rose-pine-hyprcursor";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "rose-pine-hyprcursor";
    HYPRCURSOR_SIZE = "24";
  };

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.jetbrains-mono
  ];

  # All theme-related packages
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    gnome-themes-extra
    rose-pine-hyprcursor.packages.${pkgs.system}.default
  ];
}
