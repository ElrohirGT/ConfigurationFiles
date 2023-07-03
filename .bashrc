export PATH=~/.npm-packages/bin:$PATH
export NODE_PATH=~/.npm-packages/lib/node_modules

bind '"\C-f":"D=$(fd -td -a \".*\" ~/Documents/ | fzf) && cd \"$D\" && tmux \C-M"'
bind '"\C-t":"D=$(fd -td -a \".*\" ~/Documents/ | fzf) && cd \"$D\" && tmux new-session nix-shell\C-M"'

alias graph="git log --graph --oneline"
