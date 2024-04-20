{pkgs, ...}: {
  extraPlugins = [
    (
      pkgs.vimUtils.buildVimPlugin {
        name = "doge";
        version = "v4.6.3";
        src = pkgs.fetchFromGitHub {
          owner = "kkoomen";
          repo = "vim-doge";
          # Versión 4.6.3
          # https://github.com/kkoomen/vim-doge/releases/tag/v4.6.3
          rev = "622736ca29ecd6e2720623696d48179c4da430ac";
          hash = "sha256-avWfs84aOuSV9yX6sOwAj1NOzkGfjXM7S6Wr4W5rVtA=";
        };
      }
    )
  ];
}
