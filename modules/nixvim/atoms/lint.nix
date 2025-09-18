{
  plugins.lint = {
    enable = true;
    lintersByFt = {
      go = [
        "golangcilint"
      ];
      python = [
        "pylint"
      ];
      javascript = [
        "biomejs"
      ];
      yaml = [
        "yamllint"
      ];
      dockerfile = [
        "hadolint"
      ];
      json = [
        "jsonlint"
      ];
    };
  };
}
