{ config, pkgs, inputs, ... }:

{
  #================================================================
  # PACKAGES
  #================================================================
  home.packages = with pkgs; [
    # --- CLI & System Utilities ---
    cliphist
    cmatrix
    fastfetch
    gemini-cli
    git
    starship
    wl-clipboard

    # --- Desktop Applications ---
    discord
    firefox
    gimp
    spotify
    vscode
    pavucontrol
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.tumbler

    # --- Gaming ---
    gamemode
    gamescope
    steam
    steam-run

    # --- GUI/Desktop Tools ---
    grimblast
    hyprlock
    hyprpaper
    kitty
    libnotify
    mako
    slurp
    waybar
    wofi

    # --- Applets ---
    networkmanagerapplet

    # --- Fonts ---
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];

  #================================================================
  # THEMING & FONT CONFIG
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

  fonts.fontconfig.enable = true;

  #================================================================
  # SYSTEM SETTINGS
  #================================================================
  dconf.enable = true;

  home.sessionVariables = {
    HYPRCURSOR_THEME = "rose-pine-hyprcursor";
    HYPRCURSOR_SIZE = "24";
  };

  #================================================================
  # SHELL CONFIG (.bash_profile and .bashrc)
  #================================================================
  home.file.".bash_profile".text = ''
    # Only start Hyprland if we're on TTY1 and not already in a graphical session
    if [[ -z $DISPLAY && $(tty) = /dev/tty1 && $- == *i* ]]; then
      exec Hyprland
    fi
  '';

  home.file.".bashrc".text = ''
    # Starship prompt
    eval "$(starship init bash)"

    # Load secrets (if present)
    [ -f "$HOME/.secrets" ] && source "$HOME/.secrets"

    # NixOS Configuration Shortcuts
    alias nixedit='cd /etc/nixos && code .'
    alias ns="sudo nixos-rebuild switch --flake /etc/nixos#laptop"
    alias ns-dry="sudo nixos-rebuild dry-activate --flake /etc/nixos#laptop"

    # Flake & Garbage Management
    alias flake-update="sudo nix flake update /etc/nixos && ns"
    alias nix-clean="sudo nix-collect-garbage -d"
    alias nix-du="sudo du -sh /nix/store/* | sort -hr | head -n 20"

    # Shell QoL
    alias sl='ls'
    alias q='exit'
    alias top='btm'
    alias neofetch='fastfetch'

    # Safer Shell Defaults
    set -o noclobber  # Prevent overwriting files with '>'
    set -o ignoreeof  # Prevent accidental Ctrl+D logouts
  '';

  #================================================================
  # CONFIG FILES
  #================================================================
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

  xdg.configFile."kitty/kitty.conf".text = ''
    confirm_os_window_close 0
  '';

  xdg.configFile."starship.toml".source = ./dotfiles/starship.toml;
  xdg.configFile."mako/config".source = ./dotfiles/mako/config;
  xdg.configFile."waybar/config".source = ./dotfiles/waybar/config;
  xdg.configFile."waybar/style.css".source = ./dotfiles/waybar/style.css;
  xdg.configFile."wofi/config".source = ./dotfiles/wofi/config;
  xdg.configFile."wofi/style.css".source = ./dotfiles/wofi/style.css;

  #================================================================
  # FINALIZATION
  #================================================================
  home.stateVersion = "25.05";
}