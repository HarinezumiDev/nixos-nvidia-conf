{ config, pkgs, ... }: {
  stylix = {
    enable = false;

    base16Scheme = ./lain.yaml;

    image = ./wallpapers/crimson2.png;
    polarity = "dark";

    fonts = {
      serif    = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji    = config.stylix.fonts.monospace;

      sizes.terminal = 10;
    };

    opacity = {
      desktop  = 0.3;
      terminal = 0.7;
    };

    targets.gtk.enable = false;
    targets.kitty.enable = false;
  };

  environment.systemPackages = with pkgs; [ base16-schemes ];
}
