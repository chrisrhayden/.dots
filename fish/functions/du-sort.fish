function du-sort
    command du --one-file-system --human-readable --max-depth=1 $argv[1] 2>/dev/null | sort -h
end
