abbr -a vim nvim
abbr -a cat bat
abbr -a curl curlie
abbr -a ls eza
abbr -a dus 'du -ah . | sort -rh | head -n 20'

abbr -a wpconf nvim ~/.config/hypr/hyprpaper.conf
abbr -a hconf nvim ~/.config/hypr/hyprland.conf
abbr -a hlconf nvim ~/.config/hypr/hyprlock.conf
abbr -a hiconf nvim ~/.config/hypr/hypridle.conf
abbr -a hpconf nvim ~/.config/hyprpanel/config.json
abbr -a fconf nvim ~/.config/fish/config.fish
abbr -a gconf nvim ~/.config/ghostty/config

set -g fish_key_bindings fish_vi_key_bindings
set -gx XCURSOR_THEME "WhiteSur-cursors"
set -gx XCURSOR_SIZE 24
set -gx GTK_FONT_NAME "Inter 11"

if status is-interactive
    # Commands to run in interactive sessions can go here
end
