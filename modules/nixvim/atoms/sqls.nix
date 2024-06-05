{pkgs, ...}: {
  extraPackages = with pkgs; [
    sqls
  ];

  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "sqls.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "nanotee";
        repo = "sqls.nvim";
        rev = "4b1274b5b44c48ce784aac23747192f5d9d26207";
        # SHA-256 obtained using:
        # nix-prefetch-url --unpack https://github.com/nanotee/sqls.nvim/archive/4b1274b5b44c48ce784aac23747192f5d9d26207.tar.gz
        sha256 = "0jxgsajl7plw025a0h6r3cifrj0jyszn697247ggy0arlfvnx8cc";
      };
    })
  ];

  extraConfigLua = ''
    require('lspconfig').sqls.setup{
           on_attach = function(client, bufnr)
             require('sqls').on_attach(client, bufnr) -- require sqls.nvim
           end;
           settings = {
             sqls = {
               connections = {
        {
                   driver = 'postgresql',
        	-- change the database attribute to whatever DB we're using right now
                   dataSourceName = 'host=localhost port=5432 user=postgres database=postgres',
                 },
               },
             },
           };
         }
  '';
}
