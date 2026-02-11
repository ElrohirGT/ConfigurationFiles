{
  lib,
  pkgs,
  yamlConfig,
  ...
}: let
  configFile =
    pkgs.writeText "config.yaml"
    (lib.generators.toYAML {} yamlConfig);
in
  pkgs.writeShellApplication {
    name = "wlr-which-key-wrapper";
    text = "${lib.getExe pkgs.wlr-which-key} ${configFile}";
  }
