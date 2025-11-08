// import Quickshell.Widgets
import Quickshell
import QtQuick

import qs

Rectangle {
    id: clock_rect
    anchors.centerIn: parent

    height: parent.height
    width: clock.width

    color: Style.bg
    radius: Style.radius

    Text {
        id: clock
        anchors.centerIn: parent

        leftPadding: 8
        rightPadding: 8

        readonly property string short_time: "hh:mm AP"
        readonly property string long_time: "MMM ddd yy-MM-dd hh:mm AP"
        property bool short_bool: true

        SystemClock {
            id: sys_clock
            precision: SystemClock.Seconds
        }

        font: Style.barFont
        color: Style.fontDefault

        text: Qt.formatDateTime(sys_clock.date, short_bool ? short_time : long_time)

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: () => {
                console.log(">>>>", clock.width, clock.height, parent.width, parent.height);
                console.log(">>>>", clock.width, clock.height, clock_rect.width, clock_rect.height);
                clock_rect.color = Style.bgHover;
                clock.color = Style.fontHover;
            }
            onExited: () => {
                clock_rect.color = Style.bg;
                clock.color = Style.fontDefault;
            }
            onClicked: _ => clock.short_bool = !clock.short_bool
        }
    }
}
