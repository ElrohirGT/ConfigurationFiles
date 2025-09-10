# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  inputs,
  pkgs_unstable,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/i3.nix
    ./modules/sway.nix
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

  # Enable the i3 alternative module
  i3Alt.enable = false;
  # Enable the Sway alternative module
  swayAlt.enable = true;

  # Enable GVfs, a userspace virtual filesystem.
  services.gvfs.enable = true;

  # Configure console keymap
  console.keyMap = "la-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true;
  services.pulseaudio.enable = false;
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
    extraGroups = ["networkmanager" "wheel" "adbusers" "dialout" "wireshark"];
    # packages = with pkgs; [
    #   firefox
    #   #  thunderbird
    # ];
  };

  # Importing home configuration for user elrohirgt
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    # useGlobalPkgs = true;
    # useUserPackages = true;
    users = {
      "elrohirgt" = import ./home.nix;
    };
    backupFileExtension = "backup";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Nix and Nix Store options
  nix.settings = {
    auto-optimise-store = true;
    trusted-users = ["root" "elrohirgt"];
    substituters = [
      "https://cache.nixos.org/"
      "https://nixcache.reflex-frp.org"
      "https://cache.iog.io"
      "https://digitallyinduced.cachix.org"
      "https://ghc-nix.cachix.org"
      "https://ic-hs-test.cachix.org"
      "https://kaleidogen.cachix.org"
      "https://static-haskell-nix.cachix.org"
      "https://tttool.cachix.org"
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    pkgs.man-pages
    pkgs_unstable.zed-editor
  ];

  # programs.systemtap.enable = true;

  # Wireshark
  programs.wireshark.enable = true;

  # Gaming zzz
  programs.steam.enable = true;

  # Virtual Machines (VM's)
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
    # enableKvm = true;
    addNetworkInterface = true;
  };
  virtualisation.virtualbox.guest = {
    enable = true;
  };

  # Shell Aliases
  environment.shellAliases = {
  };
  hardware.graphics.enable = true;

  # Fonts installed in the system
  # fonts.packages = with pkgs; [
  #   nerdfonts
  # ];
  fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  # This openssl package is required by nixos 23.05 but is marked as insecure.
  nixpkgs.config.permittedInsecurePackages = [
    #"openssl-1.1.1u"
    "electron-19.1.9"
    "electron-24.8.6"
    "electron-25.9.0"
  ];

  security.sudo.enable = true;

  # Enable XDG portals
  xdg.portal.enable = true;

  # http
  # services.httpd.enable = true;
  # services.httpd.adminAddr = "elrohirgt@gmail.com";
  # services.httpd.enablePHP = true; # oof... not a great idea in my opinion

  # services.httpd.virtualHosts."example.org" = {
  #   documentRoot = "/var/www/example.org";
  #   # want ssl + a let's encrypt certificate? add `forceSSL = true;` right here
  # };

  system.activationScripts = {
    wiki-tui.text = ''
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

  # For virtualisation and VM's
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["elrohirgt"];

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
    package = pkgs.nixVersions.stable;
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
  services.logind.powerKey = "ignore";
  services.logind.powerKeyLongPress = "poweroff";

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
