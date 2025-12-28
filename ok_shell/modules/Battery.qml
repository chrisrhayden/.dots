import QtQuick

import qs
import qs.components

StyleRect {
    required property string icon_str

    width: parent.height
    height: parent.height
    hovered: mouseArea.containsMouse

    Text {
        id: icon
        anchors.centerIn: parent
        font.family: "Material Symbols Sharp"
        font.pointSize: 12

        font.variableAxes: ({
                wght: 700
            })

        color: mouseArea.containsMouse ? Style.fontHover : Style.fontDefault
        text: icon_str
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }
}
