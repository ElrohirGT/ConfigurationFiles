{pkgs, ...}: {
  # PlantUML support
  plugins.plantuml-syntax = {
    enable = true;
    executableScript = "${pkgs.plantuml}/bin/plantuml";
  };
}
