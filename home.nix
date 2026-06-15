{ config, pkgs, ... }:
{
  home.username = "harinezumi";
  home.stateVersion = "25.05";
  imports = [
    ./zsh.home.nix
    ./kitty.home.nix
    ./yazi.home.nix
    ./btop.home.nix
    ./rofi.home.nix
    ./hyprland.home.nix
    ./hyprlock.home.nix
    ./hypridle.home.nix
    ./wlogout.home.nix
    ./cliphist.home.nix
    #./hyprpanel.home.nix
    ./gtk.home.nix
    ./hyprshade.home.nix
  ];
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.macchiatoGreen;
    name = "catppuccin-macchiato-green-cursors";
    size = 18;
  };
  programs.home-manager.enable = true;
}
