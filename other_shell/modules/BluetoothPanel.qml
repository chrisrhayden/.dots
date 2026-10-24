import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Bluetooth
import Quickshell.Services.Pipewire

import qs

PopupWindow {
    id: root
    required property BluetoothDevice device

    property bool btn_hover: false

    property PwNode node: {
        const addr = device.address.replace(/:/g, "_");

        return Pipewire.nodes.values.find(n => {
            if (n.isSink) {
                return n.name.includes(addr);
            }
            return false;
        });
    }

    PwObjectTracker {
        objects: [node]
    }

    implicitWidth: info_box.width
    implicitHeight: info_box.height
    color: "transparent"

    visible: {
        if (btn_hover || mouse_area.containsMouse || volume.hovered) {
            return true;
        } else {
            return false;
        }
    }

    function increase() {
        volume.increase();
    }
    function decrease() {
        volume.decrease();
    }

    MouseArea {
        id: mouse_area
        anchors.fill: parent
        hoverEnabled: true

        onWheel: function (wheel) {
            if (wheel.angleDelta.y > 0) {
                root.increase();
            } else {
                root.decrease();
            }
        }
    }

    WrapperRectangle {
        id: info_box
        // anchors.fill: parent

        color: Style.colors.bg_hover

        radius: Style.radius
        margin: 10

        Column {
            id: info
            spacing: 0

            Text {
                text: root.device.name
                font: Style.bar_font
            }
            Text {
                text: {
                    const bat = root.device.battery * 100;
                    return `Bat: %${bat}`;
                }

                font: Style.bar_font
            }

            Slider {
                id: volume
                from: 0.0
                to: 1.0
                stepSize: 0.05
                value: root.node ? root.node.audio.volume : 0
                onValueChanged: {
                    if (root.node) {
                        root.node.audio.volume = value;
                    }
                }

                background: Rectangle {
                    x: volume.leftPadding
                    y: volume.topPadding + volume.availableHeight / 2 - height / 2
                    implicitWidth: info.width
                    implicitHeight: 8
                    height: 8
                    radius: Style.radius
                    color: Style.slider_colors.empty

                    Rectangle {
                        width: volume.visualPosition * parent.width
                        height: parent.height
                        color: Style.slider_colors.full
                        radius: Style.radius
                    }
                }

                handle: Rectangle {
                    x: volume.leftPadding + volume.visualPosition * (volume.availableWidth - width)
                    y: volume.topPadding + volume.availableHeight / 2 - height / 2
                    implicitWidth: 12
                    implicitHeight: 12
                    radius: 14
                    color: Style.slider_colors.handle
                }

                hoverEnabled: true
            }
        }
    }
}
