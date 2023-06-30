export PATH=~/.npm-packages/bin:$PATH
export NODE_PATH=~/.npm-packages/lib/node_modules

bind '"\C-f":"D=$(find ~/Documents -type d -name \".*\" -prune -o -print | fzf) && cd \"$D\" && tmux \C-M"'
bind '"\C-t":"D=$(find ~/Documents -type d -name \".*\" -prune -o -print | fzf) && cd \"$D\" && tmux new-session nix-shell\C-M"'
