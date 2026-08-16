function swap
    set -l TMPFILE tmp.$fish_pid
    mv $argv[1] $TMPFILE && mv $argv[2] $argv[1] && mv $TMPFILE $argv[2]
end
