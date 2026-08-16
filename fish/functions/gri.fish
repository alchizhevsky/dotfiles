function gri --description 'Git interactive rebase against default branch fork-point'
    set -l def (_git_get_default_branch)
    
    if test (count $argv) -eq 0
        set -l fork_point (git merge-base $def HEAD 2>/dev/null)
        
        if test -n "$fork_point"
            git rebase -i $fork_point
        else
            git rebase -i $def
        end
    else
        git rebase -i $argv
    end
end
