pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: style

    property int radius: 5
    property int padding: 8
    property color separator: "white"

    property var colors: ({
            bg: "transparent",
            bg_hover: "#df6a88",
            fg: "white",
            fg_hover: "black"
        })

    property var ws_colors: ({
            fg: "white",
            fg_focused: style.colors.bg_hover,
            fg_active: style.colors.bg_hover,
            fg_hover: "#171B26",
            fg_hover_focused: "white",
            bg: style.colors.bg,
            bg_hover: style.colors.bg_hover
        })

    property var slider_colors: ({
            full: "white",
            empty: "grey",
            handle: "black"
        })

    // property color pink: "#836179"
    // font style
    property font bar_font: ({
            family: "Cartograph CF",
            pointSize: 12
        })

    property font icon_font: ({
            family: "Material Symbols Sharp",
            pointSize: 12,
            variableAxes: ({
                    wght: 700
                })
        })

    property var bluetooth_icons: ({
            off: "bluetooth_disabled",
            on: "bluetooth",
            connected: "bluetooth_connected",
            // connected: "bluetooth_connected",
            headphones: "headphones"
        })

    property var bat_dis_icons: ({
            bat_0: "battery_0_bar",
            bat_1: "battery_1_bar",
            bat_2: "battery_2_bar",
            bat_3: "battery_3_bar",
            bat_4: "battery_4_bar",
            bat_5: "battery_5_bar",
            bat_6: "battery_6_bar",
            bat_full: "battery_full"
        })
    property var bat_char_icons: ({
            bat_0: "battery_charging_20",
            bat_1: "battery_charging_30",
            bat_2: "battery_charging_40",
            bat_3: "battery_charging_50",
            bat_4: "battery_charging_60",
            bat_5: "battery_charging_70",
            bat_6: "battery_charging_80",
            bat_full: "battery_full"
        })
}
