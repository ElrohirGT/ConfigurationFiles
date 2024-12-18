{pkgs, ...}: {
  # PlantUML support
  plugins.plantuml-syntax = {
    enable = true;
    settings = {
      executable_script = "${pkgs.plantuml}/bin/plantuml";
    };
  };
}
