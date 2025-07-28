{ config, pkgs, inputs, ... }:

{
  imports = [
    # Import our new, dedicated hyprland configuration
    ./hyprland.nix
  ];

  # Packages & Fonts
  home.packages = with pkgs; [
    # CLI & System Utilities
    cliphist
    cmatrix
    fastfetch
    gemini-cli
    git
    starship
    wl-clipboard

    # Desktop Applications
    discord
    firefox
    gimp
    spotify
    vscode
    pitivi
    pavucontrol
    
    # Archiver Backends for Thunar Plugin
    zip
    unzip
    p7zip
    gzip
    bzip2
    unrar

    # Gaming (steam & gamemode are enabled system-wide)
    gamescope
    steam-run
    protontricks
    runelite

    # GUI/Desktop Tools
    grimblast
    hyprlock
    hyprpaper
    kitty
    libnotify
    mako
    slurp
    waybar
    wofi

    # Applets
    networkmanagerapplet

    # Fonts
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];
  fonts.fontconfig.enable = true;

  # Theming & Appearance
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

  # Shell, Aliases, & Environment
  programs.bash = {
    enable = true;
    profileExtra = ''
      # Start Hyprland on TTY1
      if [[ -z $DISPLAY && $(tty) = /dev/tty1 && $- == *i* ]]; then
        exec Hyprland
      fi
    '';
    bashrcExtra = ''
      # Load secrets (if present)
      [ -f "$HOME/.secrets" ] && source "$HOME/.secrets"

      # NixOS Configuration Shortcuts
      alias nixedit='cd /etc/nixos && code .'
      alias ns="sudo nixos-rebuild switch --flake /etc/nixos#laptop"
      alias ns-dry="sudo nixos-rebuild dry-activate --flake /etc/nixos#laptop"

      # Flake & Garbage Management
      alias flake-update="cd /etc/nixos && sudo nix flake update && ns"
      alias nix-clean="sudo nix-collect-garbage -d"
      alias nix-du="sudo du -sh /nix/store/* | sort -hr | head -n 20"

      # Shell QoL
      alias sl='ls'
      alias q='exit'
      alias top='btm'
      alias neofetch='fastfetch'

      # Safer Shell Defaults
      set -o noclobber
      set -o ignoreeof
    '';
  };
  # Enabling starship here automatically adds the init script to .bashrc
  programs.starship.enable = true;

  home.sessionVariables = {
    HYPRCURSOR_THEME = "rose-pine-hyprcursor";
    HYPRCURSOR_SIZE = "24";
  };
  dconf.enable = true;

  # Linked Configuration Files (Dotfiles)
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

  # Home Manager State
  home.stateVersion = "25.05";
}