function fc-fzf
    argparse 'c/copy' -- $argv

    set output (fc-list \
        | fzf \
        | sed 's/.*:\(.*\):.*/\1/'  \
        | awk '{$1=$1;print}' )

    if test -n "$_flag_copy"
        printf "%s" "$output" | wl-copy
    end

    printf '%s\n' "$output"

end
