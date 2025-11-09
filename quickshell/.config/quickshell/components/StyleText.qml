import QtQuick

import qs

Text {
    property bool hovered: false

    font: Style.barFont
    color: hovered ? Style.fontHover : Style.fontDefault
}
