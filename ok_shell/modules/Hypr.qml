pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland

Singleton {
    readonly property var workspaces: Hyprland.workspaces
    // readonly property var monitors: Hyprland.monitors

    Component.onCompleted: {
        Hyprland.refreshWorkspaces();
        Hyprland.refreshMonitors();
    }

    Connections {
        target: Hyprland

        function onRawEvent(event) {
            const name = event.name;

            if (name.endsWith("v2")) {
                return;
            }

            if (["workspace", "moveworkspace", "activespecial", "focusedmon"].includes(name)) {
                Hyprland.refreshWorkspaces();
                Hyprland.refreshMonitors();
            } else if (["openwindow", "closewindow", "movewindow"].includes(name)) {
                Hyprland.refreshToplevels();
                Hyprland.refreshWorkspaces();
            } else if (name.includes("mon")) {
                Hyprland.refreshMonitors();
            } else if (name.includes("workspace")) {
                Hyprland.refreshWorkspaces();
            } else if (name.includes("window") || name.includes("group") || ["pin", "fullscreen", "changefloatingmode", "minimize"].includes(name)) {
                Hyprland.refreshToplevels();
            }
        }
    }
}
