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
            pointSize: 14
        })

    property int startPtSize: 12

    property color fontDefault: "white"
    property color fontHover: "black"

    property color wsFocused: "#df6a88"
    property color wsHoverFocused: "white"
    property color wsActive: "#808080"

    // background style
    property int radius: 5
    property color bg: "transparent"
    property color bgHover: "#df6a88"
    // property color bgHover: pink
    property int padding: 8
    // 03

    property color separator: "white"
}
