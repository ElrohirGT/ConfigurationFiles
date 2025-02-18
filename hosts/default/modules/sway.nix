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
    services.displayManager = {
      defaultSession = "sway";

      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "catppuccin-mocha";
        package = pkgs.kdePackages.sddm;
      };
    };

    programs.sway.enable = true;
  };
}
