function ping_google
    set count 1
    printf "checking internet\n"
    while ! ping -c 1 8.8.8.8 &>/dev/null;
        printf "no connection %u\n" $count
        set count (math $count + 1)
        sleep 10
    end
end

