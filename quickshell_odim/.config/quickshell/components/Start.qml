pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import QtQuick

import qs

HoverText {
    id: root
    width: parent.height
    height: parent.height

    property bool shouldShow: false

    message: "󰣇"

    function popupHandle() {
        root.shouldShow = !root.shouldShow;
    }

    onClick: popupHandle

    LazyLoader {
        id: popup
        active: root.shouldShow

        PanelWindow {
            id: popouWin
            implicitWidth: 200
            implicitHeight: 300
            exclusionMode: ExclusionMode.Ignore
            // focusable: WlrKeyboardFocus.Exclusive
            focusable: true

            color: "transparent"

            anchors {
                left: true
                bottom: true
            }

            margins {
                bottom: root.height
                left: 14
            }

            Rectangle {
                anchors.fill: parent
                radius: Style.radius
                color: Style.bgHover

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                }

                Keys.onPressed: evt => {
                    console.log("fuck");
                    if (!mouseArea.containsMouse) {
                        root.shouldShow = false;
                    }

                    if (evt.key === Qt.Key_Escape) {
                        root.shouldShow = false;
                    }
                }
            }
        }
    }
}
