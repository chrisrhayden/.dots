function dir_size -a dir
    if not set -q dir[1]
        set dir  "."
    end

    du -hd 1 $dir 2>/dev/null | sort -h
end
