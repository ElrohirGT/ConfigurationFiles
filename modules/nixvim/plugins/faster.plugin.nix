{pkgs, ...}:
pkgs.vimUtils.buildVimPlugin {
  name = "Faster.nvim";
  src = pkgs.fetchFromGitHub {
    owner = "pteroctopus";
    repo = "faster.nvim";
    rev = "ee58dbb46e5d16b72cdfd0cd246a3b1a33ec2487";
    hash = "sha256-p5T8gl4fBfMu7UQsekOFUM7/9ow22Zwt2pfNXoobpyc=";
  };
}
