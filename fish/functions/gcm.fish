function gcm --description 'Switch to the default branch'
    set -l p (_git_get_default_branch)
    git switch $p $argv
end
