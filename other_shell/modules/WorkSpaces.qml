import Quickshell
import QtQuick
import Quickshell.Hyprland

Row {
    id: root
    required property ShellScreen screen

    height: parent.height

    Repeater {
        id: ws

        model: Hyprland.workspaces.values.filter(ws => {
            return ws.monitor?.id == Hyprland.monitorFor(root.screen)?.id;
        })

        WorkSpace {}
    }
}
