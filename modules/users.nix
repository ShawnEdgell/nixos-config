{ config, pkgs, ... }:

{
  # System user declaration
  users.users.shawn = {
    isNormalUser = true;
    description = "shawn";
    shell = pkgs.bashInteractive;
    extraGroups = [ "wheel" "networkmanager" "input" "video" ];
  };
}
