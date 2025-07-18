{ config, pkgs, ... }:

{
  # Dotfiles and shell config
  home.file.".bashrc".source = ../dotfiles/bashrc;
  home.file.".bash_profile".source = ../dotfiles/bash_profile;

  # Hyprland config
  xdg.configFile."hypr/hyprland.conf".source = ../dotfiles/hypr/hyprland.conf;
  xdg.configFile."hypr/hyprlock.conf".source = ../dotfiles/hypr/hyprlock.conf;
  xdg.configFile."hypr/hyprpaper.conf".source = ../dotfiles/hypr/hyprpaper.conf;

  # Hyprland scripts
  xdg.configFile."hypr/scripts/powermenu.sh" = {
    source = ../dotfiles/hypr/scripts/powermenu.sh;
    executable = true;
  };
  xdg.configFile."hypr/scripts/wallpaper.sh" = {
    source = ../dotfiles/hypr/scripts/wallpaper.sh;
    executable = true;
  };

  # UI theming configs
  xdg.configFile."waybar/config".source = ../dotfiles/waybar/config;
  xdg.configFile."waybar/style.css".source = ../dotfiles/waybar/style.css;
  xdg.configFile."mako/config".source = ../dotfiles/mako/config;
  xdg.configFile."wofi/config".source = ../dotfiles/wofi/config;
  xdg.configFile."wofi/style.css".source = ../dotfiles/wofi/style.css;

  home.stateVersion = "25.05";
}
