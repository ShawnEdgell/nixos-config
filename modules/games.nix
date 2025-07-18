{ config, pkgs, ... }:

{
  # Enable Steam with full support
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Enable Gamemode for performance optimization
  programs.gamemode.enable = true;

  # Optional: environment variables to help some games run better under Hyprland
  environment.sessionVariables = {
    # Gamescope often benefits from explicit renderer settings
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    __GL_THREADED_OPTIMIZATIONS = "1";
    __GL_SYNC_TO_VBLANK = "0";
    STEAM_FORCE_DESKTOPUI_SCALING = "1";
    STEAM_FRAME_FORCE_CLOSE = "1";
  };
}
