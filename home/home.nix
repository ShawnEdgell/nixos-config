# ./home/home.nix
{ config, pkgs, inputs, ... }:

{
  #================================================================
  # PACKAGES
  #================================================================
  home.packages = with pkgs; [
    # --- CLI & System Utilities ---
    git
    fastfetch
    cmatrix
    gemini-cli
    starship
    wl-clipboard # Wayland clipboard tool
    cliphist     # Clipboard history manager

    # --- GUI Applications ---
    firefox
    vscode
    gimp
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.tumbler

    # --- Desktop Environment & Tooling ---
    kitty      # Terminal
    waybar     # Status bar
    wofi       # Application launcher
    mako       # Notification daemon
    libnotify  # For sending notifications
    hyprlock   # Screen locker
    hyprpaper  # Wallpaper utility
    grimblast  # Screenshot tool
    slurp      # Screen selection tool

    # --- Applets ---
    networkmanagerapplet

    # --- Gaming ---
    steam
    steam-run
    gamemode
    gamescope

    # --- Fonts & Theming ---
    gnome-themes-extra
    adwaita-icon-theme
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.jetbrains-mono
  ];

  #================================================================
  # THEME & CONFIGURATION
  #================================================================
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "rose-pine-hyprcursor";
      package = inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default;
      size = 24;
    };
  };

  dconf.enable = true;
  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    HYPRCURSOR_THEME = "rose-pine-hyprcursor";
    HYPRCURSOR_SIZE = "24";
  };
  
  #================================================================
  # DOTFILES
  #================================================================
  home.file.".bashrc".source = ./dotfiles/bashrc;
  home.file.".bash_profile".source = ./dotfiles/bash_profile;
  
  xdg.configFile."hypr/hyprland.conf".source = ./dotfiles/hypr/hyprland.conf;
  xdg.configFile."hypr/hyprlock.conf".source = ./dotfiles/hypr/hyprlock.conf;
  xdg.configFile."hypr/hyprpaper.conf".source = ./dotfiles/hypr/hyprpaper.conf;
  xdg.configFile."hypr/scripts/powermenu.sh" = {
    source = ./dotfiles/hypr/scripts/powermenu.sh;
    executable = true;
  };
  xdg.configFile."hypr/scripts/wallpaper.sh" = {
    source = ./dotfiles/hypr/scripts/wallpaper.sh;
    executable = true;
  };
  xdg.configFile."waybar/config".source = ./dotfiles/waybar/config;
  xdg.configFile."waybar/style.css".source = ./dotfiles/waybar/style.css;
  xdg.configFile."mako/config".source = ./dotfiles/mako/config;
  xdg.configFile."wofi/config".source = ./dotfiles/wofi/config;
  xdg.configFile."wofi/style.css".source = ./dotfiles/wofi/style.css;

  home.stateVersion = "25.05";
}