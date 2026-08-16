function _git_get_default_branch
    set -l p (git rev-parse --abbrev-ref origin/HEAD 2>/dev/null | string replace 'origin/' '')

    if test -z "$p"
        set p (git branch -r | string match -r 'origin/(main|master)$' | string replace 'origin/' '' | head -n 1 | string trim)
    end

    if test -z "$p"
        set p (git branch --format='%(refname:short)' | string match -r '^(main|master)$' | head -n 1 | string trim)
    end

    if test -z "$p"; set p main; end
    echo $p
end
