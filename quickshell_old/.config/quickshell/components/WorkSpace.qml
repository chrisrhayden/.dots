// Individual ws

// import Quickshell
import Quickshell.Hyprland
import QtQuick

import qs

Rectangle {
    id: ws_box

    required property var modelData

    radius: 5

    width: parent.height
    height: parent.height
    color: Style.bg

    states: [
        State {
            when: mouseArea.containsMouse
            PropertyChanges {
                ws_box {
                    color: Style.bgHover
                }
            }
        }
    ]

    Text {
        id: ws_text
        anchors.centerIn: parent
        color: ws_box.modelData.focused ? Style.wsFocused : (ws_box.modelData.active ? Style.wsActive : Style.fontDefault)
        font: Style.barFont
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
