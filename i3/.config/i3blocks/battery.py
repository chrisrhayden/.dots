#!/usr/bin/env python3

import math, socket


levels = {
    10: "󰁺",
    20: "󰁻",
    30: "󰁼",
    40: "󰁽",
    50: "󰁾",
    60: "󰁿",
    70: "󰂀",
    80: "󰂁",
    90: "󰂂",
    100: "󰁹"
}


def get_text(path):
    text = ""

    with open(path, "r") as f:
        text = f.read()

    return text.strip()


def round_to_10(num):
    return int(math.ceil(num / 10.0) * 10)



def main():
    status = get_text("/sys/class/power_supply/BAT1/status")

    charge_now = int(get_text("/sys/class/power_supply/BAT1/charge_now"))
    charge_full = int(get_text("/sys/class/power_supply/BAT1/charge_full"))

    percent = int((charge_now / charge_full) * 100)

    if status == "Charging":
        print("󰂄", str(percent) + "%")
        print("󰂄")
    else:
        lvl_percent = round_to_10(percent)

        print(levels[lvl_percent], str(percent) + "%")
        print(levels[lvl_percent])


    if status == "Charging":
        print("#00ff00")
    elif percent < 20:
        print("#ff0000")
    elif percent < 10:
        return 33

    return 0



if __name__ == "__main__" and socket.gethostname() == "Odimm":
    ret = main()

    exit(ret)
