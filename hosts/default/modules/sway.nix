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
    xdg.portal = {
      xdgOpenUsePortal = true;
      wlr.enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        # pkgs.xdg-desktop-portal-hyprland
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
      xwayland.enable = true;
      wrapperFeatures = {
        gtk = true;
      };
    };

    environment.systemPackages = with pkgs; [
      # Catpuccin theme
      (catppuccin-sddm.override {
        flavor = "mocha";
        background = "${../login-background.jpg}";
        loginBackground = true;
      })

      qt5.qtwayland

      # Screen locking
      swaylock-effects

      # Network manager applet
      networkmanagerapplet
      networkmanager_dmenu

      # Show keys when typing
      showmethekey

      # XDG Autostart
      dex

      # OBS plugins for capturing windows in Wayland
      obs-studio-plugins.wlrobs

      # Screenshots
      grim
      slurp
      (flameshot.override {enableWlrSupport = true;})

      mako # notification system developed by swaywm maintainer
      (bemenu.override {
        x11Support = false;
        waylandSupport = true;
      }) # dmenu replacement

      # Xrandr and arandr replacement
      wlr-randr
      wdisplays

      # Clipboard history
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      cliphist

      # Alternative terminal in case ghostty keeps being slow >:v
      wezterm

      # Wallpapers
      waypaper
      swaybg
      wpaperd
    ];

    system.activationScripts = {
      swayConfig.text = ''
        cp -r /home/elrohirgt/ConfigurationFiles/sway /home/elrohirgt/.config/
      '';
      NM_dmenu.text = ''
        cp -r /home/elrohirgt/ConfigurationFiles/networkmanager-dmenu /home/elrohirgt/.config
      '';
      BG_wpaperd.text = ''
        cp -r /home/elrohirgt/ConfigurationFiles/wpaperd /home/elrohirgt/.config
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

    environment.variables = {
      GTK_USE_PORTAL = 1;
    };
  };
}
