{
  plugins.lint = {
    enable = true;
    lintersByFt = {
      go = [
        "golangcilint"
      ];
      python = [
        "ruff"
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
