import QtQuick

import qs
import qs.components

StyleRect {
    id: root

    hovered: mouseArea.containsMouse
    width: parent.height
    height: parent.height

    BatteryMon {
        id: bat_man
    }

    // property string icon_str: bat_man.icon

    Text {
        id: icon_btn
        anchors.centerIn: parent
        font.family: "Material Symbols Sharp"
        font.pointSize: 12

        font.variableAxes: ({
                wght: 700
            })

        color: mouseArea.containsMouse ? Style.fontHover : Style.fontDefault
        text: bat_man.icon
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }
}
