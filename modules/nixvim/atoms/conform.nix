{pkgs, ...}: {
  plugins.conform-nvim = {
    enable = true;
    formatOnSave = {
      lspFallback = true;
      timeoutMs = 1000;
    };
    formatters = {
      sqlfluff = {
        "inherit" = false; # Don't merge with default config
        command = "${pkgs.sqlfluff}/bin/sqlfluff";
        args = ["format" "--dialect" "postgres" "$FILENAME"];
        # Since `sqlfluff` formats the file on disk by default
        # and it doesn't support outputing the formatted file to stdout
        # we add stdin = false and a format for the temp file generated
        # for formatting.
        stdin = false;
        tmpfile_format = ".conform.deleteMe.$FILENAME";
      };
      alejandra = {
        command = "${pkgs.alejandra}/bin/alejandra";
      };
      shfmt = {
        command = "${pkgs.shfmt}/bin/shfmt";
      };
      biome = {
        "inherit" = false; # Don't merge with default config
        command = "${pkgs.biome}/bin/biome";
        args = ["format" "--write" "$FILENAME"];
        stdin = false;
        tmpfile_format = ".conform.deleteMe.$FILENAME";
      };
    };

    formattersByFt = {
      nix = ["alejandra"];
      javascript = ["biome"];
      typescript = ["biome"];
      bash = ["shfmt"];
      sql = ["sqlfluff"];
    };
  };
}
