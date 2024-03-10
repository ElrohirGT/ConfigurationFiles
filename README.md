# ElrohirGT NixOS config

My NixOS configuration uses a Nix-Flake to get everything up and running. To switch to my NixOS config use:
```bash
# If you HAVE NOT cloned the repo
sudo nixos-rebuild switch --flake github:ElrohirGT/ConfigurationFiles#foxatop
# If you HAVE cloned the repo
sudo nixos-rebuild switch --flake {repoDir}#foxatop
```

If you only want to run my Vim config then:
```bash
# If you HAVE NOT cloned the repo
sudo nixos-rebuild switch --flake github:ElrohirGT/ConfigurationFiles#vim
# If you HAVE cloned the repo
sudo nixos-rebuild switch --flake {repoDir}#vim
```

Optionally you can change the `#vim` to `#vimMinimal` for a more lightweight config.
