import QtQuick

import qs.components

StyleRect {
    anchors.centerIn: parent

    width: parent.height
    height: parent.height

    hovered: mouseArea.containsMouse

    StyleText {
        anchors.centerIn: parent
        hovered: mouseArea.containsMouse
        text: "󰣇"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }
}
