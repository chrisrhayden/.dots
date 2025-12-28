pragma Singleton
import QtQuick
// import QtQuick.Font

import Quickshell

Singleton {
    property color pink: "#965B6D"
    // property color pink: "#836179"
    // font style
    property font barFont: ({
            family: "Cartograph CF",
            pointSize: 12
        })

    property int startPtSize: 12

    property color fontDefault: "white"
    // property color fontDefault: "black"
    property color fontHover: "black"

    property color wsFocused: "#df6a88"
    // property color wsFocused: "black"
    property color wsHoverFocused: "white"
    property color wsActive: "#808080"

    // background style
    property int radius: 5
    property color bg: "transparent"
    // property color bg: "#C36C68"
    property color bgHover: "#df6a88"
    // property color bgHover: pink
    property int padding: 8
    // 03

    property color separator: "white"

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
