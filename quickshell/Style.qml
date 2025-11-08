pragma Singleton
import QtQuick

import Quickshell

Singleton {
    // font style
    property font barFont: ({
            family: "Cartograph CF",
            pointSize: 14
        })

    property int radius: 5
    property color bg: "transparent"
    property color bgHover: "#df6a88"

    property color fontDefault: "white"
    property color fontHover: "black"

    property color wsFocused: "#df6a88"
    property color wsHoverFocused: "white"
    property color wsActive: "#808080"
}
