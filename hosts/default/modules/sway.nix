{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.swayAlt;
in {
  options = {
    swayAlt.enable = lib.mkEnableOption "Enable Sway system";
  };

  config = lib.mkIf cfg.enable {
    services.gnome.gnome-keyring = {
      enable = true;
    };

    services.displayManager = {
      defaultSession = "sway";

      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "catppuccin-mocha";
        package = pkgs.kdePackages.sddm;
      };
    };

    programs.sway = {
      enable = true;
      wrapperFeatures = {
        gtk = true;
      };
    };

    environment.systemPackages = with pkgs; [
      # sway-contrib.grimshot
      grim
      slurp
      (flameshot.override {enableWlrSupport = true;})
      mako # notification system developed by swaywm maintainer
      wmenu # dmenu replacement

      # Xrandr and arandr replacement
      wlr-randr
      wdisplays

      # Clipboard history
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      cliphist
    ];

    system.activationScripts = {
      i3Config.text = ''
        cp -r /home/elrohirgt/ConfigurationFiles/sway /home/elrohirgt/.config/
      '';
    };

    security.pam.loginLimits = [
      {
        domain = "@users";
        item = "rtprio";
        type = "-";
        value = 1;
      }
    ];
  };
}
