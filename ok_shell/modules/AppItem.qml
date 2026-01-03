import Quickshell
import QtQuick

import qs
import qs.components

Rectangle {
    id: root
    required property DesktopEntry modelData

    color: Style.bg

    width: parent.width
    height: text.height

    radius: Style.radius

    Text {
        id: text

        elide: Text.ElideRight
        font.family: Style.barFont.family
        font.pointSize: Style.startPtSize

        color: hoverArea.containsMouse ? "white" : "black"

        text: modelData.name
    }

    MouseArea {
        id: hoverArea
        anchors.fill: parent
        hoverEnabled: true
    }
}
