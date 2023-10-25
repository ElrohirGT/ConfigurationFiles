
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
  let my-python-packages = p: with p; [
#	simpy
#	autopep8
#	numpy
#	networkx
    ];
  in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  # Nix config
  nix.settings.experimental-features = [ "nix-command" "flakes"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "foxatop"; # Define your hostname.
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "latam";
    xkbVariant = "";
  };

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
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Optimise the store
  nix.settings.auto-optimise-store = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Programming
    vscode.fhs
	heaptrack
	git
	gcc
	cppcheck

	# Microcontrollers
	# realvnc-vnc-viewer
	gnome.vinagre
	novnc
	putty
	rpi-imager

	# UML
	plantuml
	graphviz

	# Go
	gopls
	go

	# PHP
	php82
	php82Packages.composer
	phpactor # Language server

	# SQL
	sqls # Language server

	# Javascript
	nodejs
	yarn

	# Android Development
	android-tools
	android-studio
	android-udev-rules
	glibc

	# Kotlin
	kotlin
	kotlin-language-server

    # Nix support
    nil

    # Markdown LSP
    marksman

    # Java development
	jdk17
	# jprofiler # This profiler is commented because the free trial expired
	maven

    # C# development
	dotnet-sdk

	# C++ development
	ccls
	clang-tools

    # Python
	(python310Full.withPackages my-python-packages)

    # Latex
	texlive.combined.scheme-medium
    texlab

    # Neovim Setup
    ripgrep # For Telescope
    wl-clipboard # For copying to system keyboard
	gdb # For debugging
    nerdfonts # For custom fonts
	
	vimb

    # Art
	kdenlive
	obs-studio
	pinta
    cura
    freecad

	# GNOME extensions
	gnome.gnome-shell-extensions
	gnomeExtensions.pop-shell
	gnomeExtensions.color-picker

    # General Apps
	discord
	onlyoffice-bin
	kitty
  	tldr
	scrcpy
	gnome.dconf-editor
	zoom-us
	#osu-lazer
	obsidian
	zotero
	gnome.gnome-boxes # For virtualization
	
    # General utils
	poppler_utils # For pdf utils like pdftoppm
	wget
	zip
	p7zip # For 7z support
    unzip
	unrar # For .rar support
	nix-prefetch-git
	pkg-config
	pandoc # For converting between markup files (EG: md -> pdf)
	fzf
	fd
	ffmpeg
	moreutils
	gnuplot

	# Bullshit apps
	hollywood
	genact
	wiki-tui
	cool-retro-term
  ];

  # This openssl package is required by nixos 23.05 but is marked as insecure.
  nixpkgs.config.permittedInsecurePackages = [
    #"openssl-1.1.1u"
    "electron-24.8.6"
  ];

  # http
  services.httpd.enable = true;
  services.httpd.adminAddr = "elrohirgt@gmail.com";
  services.httpd.enablePHP = true; # oof... not a great idea in my opinion

  services.httpd.virtualHosts."example.org" = {
    documentRoot = "/var/www/example.org";
    # want ssl + a let's encrypt certificate? add `forceSSL = true;` right here
  };

  #systemd.tmpfiles.rules = [
  #  "d /var/www/example.org"
  #  "f /var/www/example.org/index.php - - - - <?php phpinfo();"
  #];

  # PostgreSQL
  # sudo -u postgres psql
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "TestDB" ];
	enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database DBuser origin-address auth-method
	  local all all trust
	  host all all ::1/128 trust
    '';
  };

  programs.tmux = {
	enable = true;
	extraConfig = ''
	  # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
	  set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      # easy-to-remember split pane commands
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

	  # Vim-like movement between panes
	  bind -r k select-pane -U
	  bind -r j select-pane -D
	  bind -r h select-pane -L
	  bind -r l select-pane -R
	'';
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = ''
        set number relativenumber
        let mapleader = " "
        luafile /home/elrohirgt/.config/nvim/init.lua
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          # Color scheme
          kanagawa-nvim

		  # Markdown
		  markdown-preview-nvim

          # Status line
          lightline-vim

		  # Kotlin
		  kotlin-vim

		  # Go
		  go-nvim

		  # C++
		  vim-clang-format

          # Treesitter
          nvim-treesitter
          nvim-treesitter-parsers.rust
          nvim-treesitter-parsers.markdown
          nvim-treesitter-parsers.latex
          nvim-treesitter-parsers.nix
          nvim-treesitter-parsers.kotlin
          nvim-treesitter-parsers.go
		  nvim-treesitter-parsers.cpp
		  nvim-treesitter-parsers.php
		  nvim-treesitter-parsers.sql

          nvim-lspconfig
          # Configuring the NVim LSP to use rust-analyzer
          rust-tools-nvim

          # Completion framework:
          nvim-cmp 
          # LSP completion source:
          cmp-nvim-lsp
          # LSP Rename
          inc-rename-nvim

          # Useful completion sources:
          cmp-nvim-lua
          cmp-nvim-lsp-signature-help
          cmp-vsnip                             
          cmp-path                              
          cmp-buffer                            
          vim-vsnip

          # Searching in projects
          telescope-nvim
          hop-nvim

          # Panels and other goodies
          nvim-tree-lua
          nvim-web-devicons
          tagbar
          todo-comments-nvim
          trouble-nvim
          comment-nvim
          vim-surround
		  vim-be-good

          # For git
          vim-fugitive
        ];
      };
    };
  };
  environment.variables.EDITOR = "nvim";

  # Bash aliases
  programs.bash.shellAliases = {
	e = "exit";
	graph = "git log --oneline --graph";
	and = "android-studio > /dev/null 2>&1 &";
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
  system.stateVersion = "23.05"; # Did you read the comment?

}
