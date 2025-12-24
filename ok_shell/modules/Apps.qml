import QtQuick
import qs.components

StyleRect {
    id: root

    required property bool startWindow

    anchors.centerIn: parent

    width: parent.height
    height: parent.height

    hovered: mouseArea.containsMouse

    StyleText {
        id: apps_icon
        anchors.centerIn: parent
        hovered: mouseArea.containsMouse

        text: "󰣇"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: bar.menuVisible.start = !bar.menuVisible.start
    }
}
