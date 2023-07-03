function remove_git_dirs
    set output (find "$PWD" -type d -name '.git' \
        && find "$PWD" -name '.gitignore')

    if test -z $output;
        printf "nothing to remove\n"
        return
    end

    printf "%s\n" $output

    read -P "remove these dirs\n (Y|n) > " will_remove

    if test "$will_remove" != "Y";
        return
    end

    for i in $output;
        # even though we ask the use lets just make sure we cant remove
        # outside the home dir anyway
        if string match -q "$HOME/?*" "$i"
            printf "removeing > %s <\n" "$i"
            rm -rf "$i"
        end
    end
end
