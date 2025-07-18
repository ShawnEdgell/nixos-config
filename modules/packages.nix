{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    ### System & CLI Utilities ###
    git
    #ffmpeg-full
    fastfetch
    brightnessctl
    gvfs
    cmatrix
    gemini-cli
    starship

    ### Desktop Applications ###
    firefox
    #discord
    #spotify
    vscode
    #obs-studio
    gimp
    #libreoffice

    ### Gaming ###
    steam
    steam-run
    gamemode
    gamescope

    ### Hyprland UI & Desktop Tools ###
    kitty
    mako
    libnotify
    waybar
    wofi
    hyprlock
    hyprpaper
    lxsession
    polkit

    ### Screenshot & Clipboard Tools ###
    grimblast
    slurp
    wl-clipboard
    cliphist

    ### Bluetooth ###
    bluez
    bluez-tools

    ### File Manager (Thunar) ###
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.tumbler
  ];
}
