function du-sort
    du --one-file-system --human-readable --max-depth=1 $argv[1] | sort -h
end
