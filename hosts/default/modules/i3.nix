{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.i3Alt;
in {
  options = {
    i3Alt.enable = lib.mkEnableOption "Enable i3 system";
  };

  config = lib.mkIf cfg.enable {
    # Configuring login screen
    services.displayManager = {
      defaultSession = "i3";

      sddm = {
        enable = true;
        theme = "catppuccin-mocha";
        package = pkgs.kdePackages.sddm;
      };
      # We need the no-log flag because lemurs tries to log to /var/log/lemurs.log
      # Which is a file that it doesn't have access to
      #    	job.execCmd = lib.mkForce "sudo ${pkgs.lemurs}/bin/lemurs";
    };

    # Enable X11
    services.xserver = {
      enable = true;
      # Configure keymap
      xkb.layout = "latam";
      xkb.variant = "";

      displayManager.session = [
        {
          manage = "desktop";
          name = "i3";
          start = ''
            exec ${pkgs.i3}/bin/i3
          '';
        }
      ];

      # Configure autolock
      xautolock = {
        enable = true;
        extraOptions = [
          "-detectsleep"
          "-time 3"
        ];
        locker = "${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 5 3";
        #locker = "if [ $(cat /proc/asound/card*/pcm*/sub*/status | grep RUNNING | wc --lines) == 0 ] then ${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 5 3 fi";
      };

      desktopManager.wallpaper.mode = "fill";

      # Activate i3
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          lm_sensors
          dmenu
          i3lock-fancy-rapid
          #i3status-rust
          brightnessctl
          networkmanagerapplet
          (catppuccin-sddm.override {
            flavor = "mocha";
            background = "${../login-background.jpg}";
            loginBackground = true;
          })
          flameshot # For taking screenshots
          feh # For image viewing
          # Use xev to interactively obtain keys to keybind
          xorg.xev
          # Use `xmodmap -pke` to obtain whole keys to keybind
          xorg.xmodmap
          xorg.xrandr # For autorandr
          arandr

          networkmanager_dmenu
          xcolor # Color picker (on X11)
          xclip # To copy to system clipboard (on X11)

          # Audio control
          pulseaudio
          ncpamixer
        ];
      };
    };
    programs.i3lock.enable = true;

    # Autorandr for auto adjusting to screens
    services.autorandr.enable = true;

    system.activationScripts = {
      i3Config.text = ''
        cp -r /home/elrohirgt/ConfigurationFiles/i3 /home/elrohirgt/.config/
      '';
    };

    environment.shellAliases = {
      iv = "feh --auto-zoom --scale-down"; # Display image scaled down to window space
      fclip = "xclip -sel clip"; # Copy file to paperclip (only on X11)
      xpick = "xcolor | fclip";
    };
  };
}
