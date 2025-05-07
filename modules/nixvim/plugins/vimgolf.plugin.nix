{pkgs, ...}: {
  package = pkgs.vimUtils.buildVimPlugin {
    name = "Golf.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "vuciv";
      repo = "golf";
      rev = "abf1bc0c1c4a5482b4a4b36b950b49aaa0f39e69";
      hash = "sha256-p5T8gl4fBfMu7UQsekOFUM7/9ow22Zwt2pfNXoobpyc=";
    };
  };
  # luaConfig = ''
  #   require('faster').setup()
  # '';
}
