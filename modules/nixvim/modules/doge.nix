{pkgs, ...}: {
  extraPlugins = [
    (
      pkgs.vimUtils.buildVimPlugin {
        name = "doge";
        version = "v4.7.0";
        src = pkgs.fetchFromGitHub {
          owner = "kkoomen";
          repo = "vim-doge";
          # Versión 4.6.3
          # https://github.com/kkoomen/vim-doge/releases/tag/v4.6.3
          rev = "ca6f40e7d1262ad0cf13e8cf7887fe7ae05c9949";
          hash = "sha256-JuLacXfF94/AJ2waCN9KFClGPsa4WB4mUAXVuozW22o=";
        };
      }
    )
  ];
  extraConfigLua = ''
    vim.g.doge_install_path = '/home/elrohirgt/vim-doge-bin/'
  '';
}
