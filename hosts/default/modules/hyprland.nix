{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.hyprlandAlt;
in {
  options = {
    hyprlandAlt.enable = lib.mkEnableOption "Enable hyprland system";
  };

  config = lib.mkIf cfg.enable {
    xdg.portal = {
      xdgOpenUsePortal = true;
      wlr.enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
        # pkgs.xdg-desktop-portal-gnome
      ];

      config = {
        sway = {
          # default = ["wlr" "gtk"];
          "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
        };
      };
    };
    services.gnome.gnome-keyring = {
      enable = true;
    };

    # Configure loading
    services.xserver = {
      # Configure keymap
      xkb.layout = "us,latam";
      xkb.variant = ",qwerty";
      xkb.options = "grp:alt_shift_toggle,grp_led:scroll";
    };

    # Configuring login screen
    services.displayManager = {
      defaultSession = "hyprland-uwsm";

      sddm = {
        enable = true;
        theme = "catppuccin-mocha";
        package = pkgs.kdePackages.sddm;
        wayland.enable = true;
      };
      # We need the no-log flag because lemurs tries to log to /var/log/lemurs.log
      # Which is a file that it doesn't have access to
      #    	job.execCmd = lib.mkForce "sudo ${pkgs.lemurs}/bin/lemurs";
    };

    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
    environment.variables.NIXOS_OZONE_WL = "1";
    environment.variables.GTK_USE_PORTAL = 1;
  };
}
