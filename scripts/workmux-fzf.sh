#!/usr/bin/env fish

set cmd $argv[1]
test -z "$cmd"; and exit 1

set selection (workmux list | tail -n +2 | fzf)
test -z "$selection"; and exit 0

set branch (string split --no-empty ' ' -- "$selection")[1]

workmux "$cmd" "$branch"
or begin
    echo
    echo "workmux $cmd failed. Press any key to close."
    read -n 1 -s
end
