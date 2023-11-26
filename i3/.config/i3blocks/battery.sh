#!/usr/bin/env bash

if [[ $(hostnamectl hostname) == "Odimm" ]]; then
    BAT="$(cat /sys/class/power_supply/BAT1/capacity)"
    STATUS="$(cat /sys/class/power_supply/BAT1/status)"

    printf 'bat %s%%\n' "$BAT"
    printf 'bat %s%%\n' "$BAT"

    if [[  $STATUS == "Charging" ]]; then
        printf '#00ff00\n'
    elif (($BAT < 5)); then
        exit 33
    elif (($BAT < 20)); then
        printf '#ff8000\n'
    fi
fi
