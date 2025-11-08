pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Hyprland
import QtQuick

Row {
    id: ws

    required property var screen

    anchors.fill: parent

    Repeater {
        model: Hyprland.workspaces.values.filter(ws => {
            return ws.monitor?.id == Hyprland.monitorFor(screen)?.id;
        })

        WorkSpace {}
    }
}
