function clean_node
    function _clean_node
        set cur_dir $argv[1]

        for d in $cur_dir/*;
            if test -e $d/node_modules
                echo "clean $d"
                cd $d
                rm -rf node_modules
                cd -
            else
                _clean_node $d
            end
        end
    end

    _clean_node $PWD
end
