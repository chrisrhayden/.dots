import Quickshell
import QtQuick
import QtQuick.Layouts

import qs
import qs.components

StyleRect {
    id: root

    required property PersistentProperties menuVisible

    MouseArea {
        id: rootMA
        anchors.fill: parent
        hoverEnabled: true
    }

    hovered: rootMA.containsMouse

    width: items.implicitWidth
    height: items.implicitHeight

    Column {
        id: items
        width: childrenRect.width
        height: childrenRect.height

        StyleRect {
            width: fuck.width
            height: fuck.height

            StyleText {
                id: fuck
                anchors.centerIn: parent
                text: "fuck"
                color: "black"
            }
        }
        StyleRect {
            width: you.width
            height: you.height

            hovered: youMouse.containsMouse

            StyleText {
                id: you
                anchors.centerIn: parent
                text: "you"
                hovered: youMouse.containsMouse
            }

            MouseArea {
                id: youMouse
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    console.log(items.width, items.height);
                }
            }
        }
    }
}
