function glg --description 'Git log for current feature branch'
    set -l def (_git_get_default_branch)
    if test (count $argv) -eq 0
        git log --graph --oneline --boundary $def..HEAD
    else
        git log --graph --oneline $argv
    end
end
