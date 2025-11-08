pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Controls

HoverText {
    id: root

    property bool showMenu: false
    property bool loadMenu: false

    width: parent.height
    height: parent.height

    text: "󰣇"

    onClick: () => {
        if (!root.loadMenu) {
            root.loadMenu = true;
        }
        root.showMenu = !root.showMenu;
        console.log(">>>>>>>>");
    }

    Loader {
        anchors.fill: parent
        active: root.loadMenu

        Rectangle {
            id: inner
            visible: root.showMenu

            anchors.left: parent.left
            anchors.bottom: parent.top

            // y: -(parent.y + implicitHeight)

            implicitWidth: 200
            implicitHeight: 200
        }
    }
}
