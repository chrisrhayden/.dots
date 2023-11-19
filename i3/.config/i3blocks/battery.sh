#!/usr/bin/env bash

if [[ $(hostnamectl hostname) == "Odimm" ]]; then
    BAT="$(acpi -b | grep --perl-regexp --only-matching '\d\d?%')"

    printf 'bat %s\n' "$BAT"
    printf 'bat %s\n' "$BAT"

    if [[ ${BAT%?} -le 5 ]]; then
        exit 33
    elif [[ ${BAT%?} -le 20 ]]; then
        printf '#ff8000\n'
    fi
fi
