{pkgs, ...}:
pkgs.writeShellApplication
{
  name = "wallpaper-changer";
  text = ''
    WALLPAPER_DIRECTORY=${./wallpapers/.}

    WALLPAPER=$(find "$WALLPAPER_DIRECTORY" -type f | shuf -n 1)

    hyprctl hyprpaper preload "$WALLPAPER"
    hyprctl hyprpaper wallpaper ",$WALLPAPER"

    sleep 0.5
    hyprctl hyprpaper unload unused
  '';
}
