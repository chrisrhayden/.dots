import QtQuick

import qs

Rectangle {
    id: root

    property bool hovered: false

    color: hovered ? Style.bgHover : Style.bg
    radius: Style.radius
}
