import QtQuick
import qs.components

StyleRect {
    anchors.centerIn: parent

    height: parent.height
    width: parent.height

    hovered: mouseArea.containsMouse

    StyleText {
        id: innerText
        anchors.centerIn: parent
        hovered: mouseArea.containsMouse

        text: "⭘"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }
}
