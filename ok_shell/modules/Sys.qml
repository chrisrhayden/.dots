import QtQuick

import qs.components

StyleRect {
    anchors.centerIn: parent

    width: parent.height
    height: parent.height

    hovered: mouseArea.containsMouse

    StyleText {
        id: text
        anchors.centerIn: parent

        anchors.verticalCenterOffset: 1
        // anchors.horizontalCenterOffset: -1

        hovered: mouseArea.containsMouse

        font.variableAxes: ({
                wght: 700
            })

        font.family: "Material Symbols Sharp"
        text: "power_settings_new"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }
}
