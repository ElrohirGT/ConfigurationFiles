{ config, pkgs, lib, ... }:

 let my-python-packages = p: with p; [
#       simpy
#       autopep8
#       numpy
#       networkx
    ];
  in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "elrohirgt";
  home.homeDirectory = "/home/elrohirgt";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
		# Compression utilities
		zip
		unzip
		rar
		p7zip

		fd # find alternative
		eza # ls alternative
		zoxide # cd alternative
		choose # select text between commands
		rnr # Command line tool to batch rename files
		gitui # Command line git client
		rm-improved # rm command with trashbin

		tldr
		scrcpy
		wl-clipboard # To copy to system clipboard (on wayland)
		xclip # To copy to system clipboard (on X11)
		wget
		poppler_utils # For pdf utilities (EG: pdftoppm)
		ffmpeg
		moreutils # Collection of the unix tools that nobody thought to write long ago when unix was young.
		renameutils
		lighttpd # For git instaweb
		nixos-icons

		# Bullshit apps
		hollywood
        genact
        wiki-tui

		# Programming
		heaptrack
		gh # Github CLI client
		gcc
		cppcheck
		arduino-cli	
		gdb # For debugging

		# Microcontrollers
		gnome.vinagre
		rpi-imager

		# UML
		plantuml
		graphviz

		# Go
		gopls
		go

		# SQL
		sqls # Language server
		oracle-instantclient
		pgmanage

		# Javascript
		nodejs
		yarn

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
		nodePackages.pyright

		# Latex
		texlive.combined.scheme-medium
		texlab

		# Haskell
		stack
		haskell.compiler.native-bignum.ghc98
		haskell-language-server

		# Neovim Setup
		ripgrep # For Telescope
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bat.enable = true;
  programs.pandoc.enable = true; # For converting between markup files (EG: md -> pdf) 
  programs.fzf.enable = true;
  programs.vscode.enable = true;

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
				oldNormal    ="red bold";
				oldHighlight ="red bold 52";
				newNormal    ="green bold";
				newHighlight ="green bold 22";
			};
			diff = {
				meta       ="11";
				frag       ="magenta bold";
				func       ="146 bold";
				commit     ="yellow bold";
				old        ="red bold";
				new        ="green bold";
				whitespace ="red reverse";
			};
		};
	};
  };
  programs.git-cliff.enable = true;

  # Kitty
  programs.kitty = {
	enable = true;
	settings = {
		# Window settings (Removes awkward borders
		draw_minimal_borders = true;
		hide_window_decorations = true;
		window_margin_width = 0;

		# Color Scheme (There are other attributes)
		background = "#0e1419";
		foreground = "#e5e1cf";
		cursor = "#f19618";
		selection_background = "#243340";
		color0 = "#000000";
		color8 = "#323232";
		color1 = "#ff3333";
		color9 = "#ff6565";
		color2 = "#b8cc52";
		color10 = "#e9fe83";
		color3 = "#e6c446";
		color11 = "#fff778";
		color4 = "#36a3d9";
		color12 = "#68d4ff";
		color5 = "#f07078";
		color13 = "#ffa3aa";
		color6 = "#95e5cb";
		color14 = "#c7fffc";
		color7 = "#ffffff";
		color15 = "#ffffff";
		selection_foreground = "#0e1419";
	};
  };

  # Firefox config
  programs.firefox = {
	enable = true;
	package = null; # Firefox packages is installed through NixOS configuration.nix file
	profiles = {
		default = {
			name="Personal";
			search = {
				force = true;
				engines = {
                 "Nix Packages" = {
                   urls = [{
                     template = "https://search.nixos.org/packages";
                     params = [
                       { name = "type"; value = "packages"; }
                       { name = "query"; value = "{searchTerms}"; }
                     ];
                   }];

                   icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                   definedAliases = [ "@np" ];
                 };

                 "NixOS Wiki" = {
                   urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
                   iconUpdateURL = "https://nixos.wiki/favicon.png";
                   updateInterval = 24 * 60 * 60 * 1000; # every day
                   definedAliases = [ "@nw" ];
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
# Adds bindings to ctrl+f and ctrl+t to search inside documents.
bind '"\C-f":"D=$(fd -td -a \".*\" ~/Documents/ | fzf) && cd \"$D\" && tmux \C-M"'
bind '"\C-t":"D=$(fd -td -a \".*\" ~/Documents/ | fzf) && cd \"$D\" && tmux new-session nix-shell\C-M"'
eval "$(zoxide init bash)"
		'';
		shellAliases = {
			e = "exit"; # Exit
			graph = "git log --oneline --graph"; # graph git log
			and = "android-studio > /dev/null 2>&1 &"; # Start android studio in background
			iv = "feh --auto-zoom --scale-down"; # Display image scaled down to window space
			ls = "eza";
			cd = "z";
			rm = "rip";
			xclip = "xclip -sel clip";
			gup = "git commit -am 'feat: Update files' && git status";
			gs = "git status";

			# Neovim aliases
			vi = "nix run ~/.config/NixNeovim/";
			vim = "nix run ~/.config/NixNeovim/";
			nvim = "nix run ~/.config/NixNeovim/";
		};
   };
}
