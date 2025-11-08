import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import Quickshell

import "components"

Scope {
    id: root

    Connections {
        target: Hyprland

        function onRawEvent(event: HyprlandEvent): void {
            Hyprland.refreshWorkspaces();
            Hyprland.refreshMonitors();
            Hyprland.refreshToplevels();
            console.log(">>>>>>>> in root");
            const n = event.name;
            if (n.endsWith("v2"))
                return;

            if (["workspace", "moveworkspace", "activespecial", "focusedmon"].includes(n)) {
                Hyprland.refreshWorkspaces();
                Hyprland.refreshMonitors();
            } else if (["openwindow", "closewindow", "movewindow"].includes(n)) {
                Hyprland.refreshToplevels();
                Hyprland.refreshWorkspaces();
            } else if (n.includes("mon")) {
                Hyprland.refreshMonitors();
            } else if (n.includes("workspace")) {
                Hyprland.refreshWorkspaces();
            } else if (n.includes("window") || n.includes("group") || ["pin", "fullscreen", "changefloatingmode", "minimize"].includes(n)) {
                Hyprland.refreshToplevels();
            }
        }
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: win
            required property var modelData
            screen: modelData

            color: Style.bg

            anchors {
                top: false
                left: true
                right: true
                bottom: true
            }

            margins {
                right: 14
                left: 14
            }

            implicitHeight: 26
            exclusionMode: ExclusionMode.Ignore

            Bar {
                screen: win.screen
            }
        }
    }
}
