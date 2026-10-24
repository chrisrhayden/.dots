import QtQuick
import Quickshell.Hyprland

import qs

Rectangle {
    id: root
    required property HyprlandWorkspace modelData

    height: parent.height
    width: parent.height

    color: Style.ws_colors.bg
    radius: Style.radius

    Text {
        id: ws_text
        anchors.centerIn: parent
        font: Style.bar_font
        color: {
            if (parent.modelData.focused) {
                return Style.ws_colors.fg_focused;
            } else if (parent.modelData.active) {
                return Style.ws_colors.fg_active;
            } else {
                return Style.ws_colors.fg;
            }
        }
        text: root.modelData.name
    }

    states: [
        State {
            when: mouse_area.containsMouse
            PropertyChanges {
                ws_text.color: {
                    if (root.modelData.focused) {
                        return Style.ws_colors.fg_hover_focused;
                    }
                    return Style.ws_colors.fg_hover;
                }

                root.color: Style.ws_colors.bg_hover
            }
        }
    ]

    MouseArea {
        id: mouse_area
        anchors.fill: parent
        hoverEnabled: true
        onClicked: mouse => {
            if (mouse.button === 1) {
                root.modelData.activate();
            }
        }
    }
}
