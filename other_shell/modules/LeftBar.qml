import QtQuick

import Quickshell.Widgets

WrapperItem {
    id: root
    required property var screen

    height: parent.height

    WorkSpaces {
        screen: root.screen
    }
}
