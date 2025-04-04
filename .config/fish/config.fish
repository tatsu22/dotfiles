if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path /usr/local/go/bin
fish_add_path ~/.local/bin
fish_add_path ~/.local/scripts

alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

starship init fish | source
