function clean_cargo
    function _clean_cargo
        set cur_dir $argv[1]

        for d in $cur_dir/*;
            if test -e $d/Cargo.toml
                echo "clean $d"
                cd $d
                cargo clean
                cd -
            else
                _clean_cargo $d
            end
        end
    end

    _clean_cargo $PWD
end
