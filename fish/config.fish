abbr -a vim nvim
abbr -a curl curlie
abbr -a ls eza
abbr -a dus 'du -ah . | sort -rh | head -n 20'

abbr -a fconf 'cd ~/.config/fish/ && nvim config.fish'
abbr -a hconf 'cd ~/.config/hypr/ && nvim '
abbr -a gconf nvim ~/.config/ghostty/config
abbr -a vimconf nvim ~/.config/nvim/

abbr -a g   git
abbr -a gst git status -s
abbr -a gsw git switch
abbr -a gsc git switch -c
abbr -a gl  git pull
abbr -a gp  git push
abbr -a gb  git branch

set -g fish_key_bindings fish_vi_key_bindings

if test -f ~/.config/fish/work.fish
    source ~/.config/fish/work.fish
end

starship init fish | source
