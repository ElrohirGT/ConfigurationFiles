# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 2;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "elrohirgt"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Guatemala";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_GT.UTF-8";
    LC_IDENTIFICATION = "es_GT.UTF-8";
    LC_MEASUREMENT = "es_GT.UTF-8";
    LC_MONETARY = "es_GT.UTF-8";
    LC_NAME = "es_GT.UTF-8";
    LC_NUMERIC = "es_GT.UTF-8";
    LC_PAPER = "es_GT.UTF-8";
    LC_TELEPHONE = "es_GT.UTF-8";
    LC_TIME = "es_GT.UTF-8";
  };

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  # services.gnome.gnome-browser-connector.enable = true;

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
          background = "${./login-background.jpg}";
          loginBackground = true;
        })
        flameshot # For taking screenshots
        feh # For image viewing
        nomacs
        # Use xev to interactively obtain keys to keybind
        xorg.xev
        # Use `xmodmap -pke` to obtain whole keys to keybind
        xorg.xmodmap

        # Audio control
        pulseaudio
        ncpamixer
      ];
    };
  };
  hardware.opengl.enable = true;
  programs.i3lock.enable = true;

  # Autorandr for auto adjusting to screens
  services.autorandr.enable = true;

  # Configure console keymap
  console.keyMap = "la-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.elrohirgt = {
    isNormalUser = true;
    description = "ElrohirGT";
    extraGroups = ["networkmanager" "wheel" "adbusers" "dialout"];
    packages = with pkgs; [
      firefox
      #  thunderbird
    ];
  };

  # Importing home configuration for user elrohirgt
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      "elrohirgt" = import ./home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Nix and Nix Store options
  nix.settings.auto-optimise-store = true;
  nix.settings.trusted-users = [
    "root"
    "elrohirgt"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vimb
    manix # Nix documentation searcher
    xcolor
    xclip # To copy to system clipboard (on X11)
    inxi
		dbeaver

    # Art
    kdenlive
    obs-studio
    pinta
    gimp
    cura
    freecad
    unetbootin # For bootable USBs

    # GNOME extensions
    # gnome.gnome-shell-extensions
    # gnomeExtensions.pop-shell
    # gnomeExtensions.color-picker

    # General Apps
    litecli
    discord
    onlyoffice-bin
    # gnome.dconf-editor
    zoom-us
    #osu-lazer
    obsidian
    zotero
    # gnome.gnome-boxes # For virtualization
    element-desktop # Matrix client
    vlc

    # General utils
    xorg.xrandr # For autorandr
    arandr
    nix-prefetch-git
    pkg-config
    gnuplot
    geeqie # For duplicate images detection

    # Bullshit apps
    cool-retro-term

    # Run commands in an FHS compliant environment
    steam-run
  ];

  # Shell Aliases
  environment.shellAliases = {
    fclip = "xclip -sel clip"; # Copy file to paperclip (only on X11)
    xpick = "xcolor | fclip";
  };

  # Fonts installed in the system
  fonts.packages = with pkgs; [
    nerdfonts
  ];

  # This openssl package is required by nixos 23.05 but is marked as insecure.
  nixpkgs.config.permittedInsecurePackages = [
    #"openssl-1.1.1u"
    "electron-19.1.9"
    "electron-24.8.6"
    "electron-25.9.0"
  ];

  security.sudo = {
    enable = true;
    extraRules = [
      {
        commands = [
          {
            command = "${pkgs.lemurs}/bin/lemurs";
            options = ["NOPASSWD"];
          }
        ];
        groups = ["wheel"];
      }
    ];
  };

  # http
  # services.httpd.enable = true;
  # services.httpd.adminAddr = "elrohirgt@gmail.com";
  # services.httpd.enablePHP = true; # oof... not a great idea in my opinion

  services.httpd.virtualHosts."example.org" = {
    documentRoot = "/var/www/example.org";
    # want ssl + a let's encrypt certificate? add `forceSSL = true;` right here
  };

  system.activationScripts = {
    i3Config.text = ''
      cp -r /home/elrohirgt/ConfigurationFiles/i3 /home/elrohirgt/.config/
    '';
    wiki-tui.text = ''
      #mkdir ~/.config/wiki-tui
      cp -r /home/elrohirgt/ConfigurationFiles/wiki-tui /home/elrohirgt/.config/
    '';
  };

  # PostgreSQL
  # sudo -u postgres psql
  services.postgresql = {
    enable = true;
    ensureDatabases = ["TestDB"];
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
         #type database DBuser origin-address auth-method
      local all all trust
      host all all ::1/128 trust
    '';
  };

  # Libvirt
  # For virtualisation and VM's
  virtualisation.libvirtd.enable = true;

  # Docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Nix config
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.adb.enable = true;

  # Enables JAVA on the system, sets JAVA_HOME and other configs
  programs.java.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
