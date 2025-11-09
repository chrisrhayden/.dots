// Individual ws

// import Quickshell
import Quickshell.Hyprland
import QtQuick

import qs
import qs.components

StyleRect {
    id: ws_box

    required property var modelData

    width: parent.height
    height: parent.height

    hovered: mouseArea.containsMouse

    Text {
        id: ws_text
        anchors.centerIn: parent

        font: Style.barFont

        color: ws_box.modelData.focused ? Style.wsFocused : (ws_box.modelData.active ? Style.wsActive : Style.fontDefault)
        text: ws_box.modelData.name

        states: [
            State {
                when: mouseArea.containsMouse
                PropertyChanges {
                    ws_text {
                        color: ws_box.modelData.focused ? Style.wsHoverFocused : Style.fontHover
                    }
                }
            }
        ]
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: mouse => {
            if (mouse.button === 1) {
                Hyprland.dispatch(`workspace ${ws_box.modelData.id}`);
            }
        }
    }
}
