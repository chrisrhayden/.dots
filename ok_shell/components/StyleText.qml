import QtQuick

import qs

Text {
    property bool hovered: false

    font.family: Style.barFont.family
    font.pointSize: Style.barFont.pointSize
    color: hovered ? Style.fontHover : Style.fontDefault
}
