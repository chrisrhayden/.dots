import Quickshell.Hyprland
import QtQuick

Row {
    id: ws
    anchors.fill: parent

    required property var screen

    Repeater {
        model: Hyprland.workspaces.values.filter(ws => {
            return ws.monitor?.id == Hyprland.monitorFor(screen)?.id;
        })

        WorkSpace {}
    }
}
