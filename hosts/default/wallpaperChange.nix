{pkgs, ...}:
pkgs.writeShellApplication
{
  name = "wallpaper-changer";
  text = ''
    		WALLPAPER_DIRECTORY=${./wallpapers/.}

    # Wait for hyprpaper's IPC to actually be up
    	for _ in $(seq 1 20); do
    if find "''${XDG_RUNTIME_DIR}/hypr" -name ".hyprpaper.sock" 2>/dev/null | grep -q .; then
    			break
    		fi

    		sleep 0.5
    	done

    		WALLPAPER=$(find "$WALLPAPER_DIRECTORY" -type f | shuf -n 1)

    		hyprctl hyprpaper wallpaper ",$WALLPAPER"
  '';
}
