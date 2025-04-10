{
  config,
  pkgs,
  inputs,
  pkgs_unstable,
  ...
}: let
  my-python-packages = p:
    with p; [
      #       simpy
      #       autopep8
      #       numpy
      #       networkx
    ];
  vimRice = inputs.self.outputs.packages.${pkgs.system}.vim;
  vimRiceBin = "${inputs.self.outputs.packages.${pkgs.system}.vim}/bin/nvim";
in {
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "elrohirgt";
  home.homeDirectory = "/home/elrohirgt";

  home.sessionVariables = {
    EDITOR = "${vimRiceBin}";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  home.packages = let
    guiApps = [
      pkgs.dbeaver-bin
      pkgs.sonic-pi
      pkgs.jetbrains.mps
      pkgs.rstudio
      pkgs.vscode-fhs
      pkgs.qbittorrent
      pkgs.kiwix
      # pkgs.zed-editor
      pkgs.ghostty
      pkgs.postman
      pkgs.mongodb-compass

      # Art
      pkgs.kdenlive
      pkgs.obs-studio
      pkgs.pinta
      pkgs.gimp
      # Broken for 24.11!
      # pkgs.cura
      pkgs.freecad
      pkgs.unetbootin # For bootable USBs

      # General
      pkgs.discord
      pkgs.zoom-us
      pkgs.obsidian
      pkgs.vlc
      pkgs.geeqie # For duplicate images detection
      pkgs.imv # For image viewing
      pkgs.mpv # For video viewing
      pkgs.onlyoffice-desktopeditors # For local word and other office docs
    ];

    terminalUtilities = [
      # Installing the vim package from outputs
      vimRice
      pkgs.alejandra # nix formatter
      pkgs.btop # Fancy process monitor
      pkgs.gh # Github from the command line

      pkgs.manix # Nix documentation searcher
      pkgs.xcolor
      pkgs.xclip # To copy to system clipboard (on X11)
      pkgs.inxi # Get information about the system
      pkgs.litecli
      pkgs.cloc # Program that counts lines of code

      pkgs.writedisk # Utility for creating bootable usb's

      # Compression utilities
      pkgs.zip
      pkgs.unzip
      pkgs.rar
      pkgs.p7zip

      # VM utilities
      pkgs.qemu
      pkgs.virt-v2v

      pkgs.fd # find alternative
      pkgs.eza # ls alternative
      pkgs.zoxide # cd alternative
      pkgs.choose # select text between commands
      pkgs.rnr # Command line tool to batch rename files
      pkgs.gitui # Command line git client
      pkgs.rm-improved # rm command with trashbin
      pkgs.ripgrep # Search for a pattern recursively

      # Connect to android file system
      pkgs.go-mtpfs
      # pkgs.simple-mtpfs # Fast but also fails randomly and with no explanation
      # pkgs.jmtpfs # Slow garbage, fucking java

      pkgs.tldr
      pkgs.scrcpy
      pkgs.poppler_utils # For pdf utilities (EG: pdftoppm)
      pkgs.ffmpeg
      # pkgs.moreutils # Collection of the unix tools that nobody thought to write long ago when unix was young.
      pkgs.parallel-full
      # pkgs.renameutils
      pkgs.lighttpd # For git instaweb

      # Nix LSP
      pkgs.nixd
    ];

    bullshitApps = [
      pkgs.hollywood
      pkgs.genact
      pkgs.wiki-tui
      pkgs.cool-retro-term
    ];

    programming = [
      # Python
      (pkgs.python3.withPackages my-python-packages)

      # Latex
      pkgs.texlive.combined.scheme-medium
      pkgs.texlab

      # General
      pkgs.gdb
      pkgs.heaptrack
      pkgs.nix-prefetch-git
      pkgs.pkg-config
    ];
  in
    guiApps ++ programming ++ bullshitApps ++ terminalUtilities;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bat.enable = true;
  programs.pandoc.enable = true; # For converting between markup files (EG: md -> pdf)
  programs.fzf.enable = true;

  # Git config
  programs.git = {
    enable = true;
    userName = "ElrohirGT";
    userEmail = "elrohirgt@gmail.com";
    diff-so-fancy.enable = true;
    extraConfig = {
      color = {
        ui = true;
        diff-highlight = {
          oldNormal = "red bold";
          oldHighlight = "red bold 52";
          newNormal = "green bold";
          newHighlight = "green bold 22";
        };
        diff = {
          meta = "11";
          frag = "magenta bold";
          func = "146 bold";
          commit = "yellow bold";
          old = "red bold";
          new = "green bold";
          whitespace = "red reverse";
        };
      };
    };
  };
  programs.git-cliff.enable = true;

  # Firefox config
  programs.firefox = {
    enable = true;
    # package = null; # Firefox packages is installed through NixOS configuration.nix file
    profiles = {
      default = {
        name = "Personal";
        search = {
          force = true;
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };

            "NixOS Wiki" = {
              urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = ["@nw"];
            };

            "Bing".metaData.hidden = true;
            "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
          };
        };
      };
      universidad = {
        id = 1;
        name = "Universidad";
      };
      explorax = {
        id = 2;
        name = "ExploraX";
      };
    };
  };

  # Tmux config
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

  # Bash Configuration
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      # Changes the default node modules installation path
      export PATH=~/.npm-packages/bin:$PATH
      export NODE_PATH=~/.npm-packages/lib/node_modules
    '';
    initExtra = ''
      # Adds bindings to ctrl+f inside documents.
      bind '"\C-f":"D=$(fd -td -a \".*\" ~/Documents/ | fzf) && cd \"$D\" && tmux \C-M"'
      eval "$(zoxide init bash)"
    '';
    shellAliases = {
      e = "exit"; # Exit
      graph = "git log --oneline --graph"; # graph git log
      and = "android-studio > /dev/null 2>&1 &"; # Start android studio in background
      ls = "eza";
      cd = "z";
      rm = "rip";
      gup = "git commit -am 'feat: Update files' && git status";
      gs = "git status";
      gp = "git push";

      # Neovim aliases
      vi = "nix run github:ElrohirGT/ConfigurationFiles#vim";
      vim = "${vimRiceBin}";
      nvim = "${vimRiceBin}";
    };
  };

  programs.i3status-rust = {
    enable = true;
    bars = {
      default = {
        blocks = [
          {
            block = "disk_space";
            path = "/";
            info_type = "available";
            alert_unit = "GB";
            interval = 20;
            alert = 10.0;
            warning = 20.0;
            format = " $icon root: $available.eng(w:2) ";
          }
          {
            block = "memory";
            format = " $icon $mem_total_used_percents.eng(w:2) ";
            format_alt = " $icon_swap $swap_used_percents.eng(w:2) ";
          }
          {
            block = "cpu";
            interval = 1;
          }
          {
            block = "load";
            format = " $icon $1m ";
            interval = 1;
          }
          {
            block = "sound";
          }
          {
            block = "backlight";
          }
          {
            block = "time";
            format = " $timestamp.datetime(f:'%a %d/%m %R') ";
            interval = 60;
          }
          {
            block = "temperature";
            format = " $icon $average avg ";
            format_alt = " $icon $min min, $max max, $average avg ";
            interval = 10;
          }
          {
            block = "battery";
          }
        ];
        settings = {
          theme = {
            theme = "solarized-dark";
            overrides = {
              idle_bg = "#710193";
              idle_fg = "#abcdef";
            };
          };
          icons = {
            icons = "awesome4";
          };
        };
      };
    };
  };

  # Enable wallpaper software
  services.random-background = {
    enable = true;
    imageDirectory = "%h/ConfigurationFiles/hosts/default/wallpapers";
    interval = "30m";
  };

  home.file.".config/ghostty/config" = {
    enable = true;
    source = ../../ghostty/config;
  };
}
