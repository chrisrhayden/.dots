pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls

import qs
import build

WrapperRectangle {
    id: root
    property string input_text
    required property PersistentProperties menuVisible

    margin: 8

    radius: Style.radius

    color: Style.bgHover

    WrapperRectangle {
        width: app_list.width
        height: app_list.height

        color: Style.bgHover

        Column {
            id: app_list

            TextField {
                id: input
                width: parent.width

                background: null

                font: Style.barFont

                color: "white"

                placeholderText: "apps"

                onAccepted: {
                    view.currentItem.modelData.execute();
                    root.menuVisible.start = false;
                }

                Component.onCompleted: forceActiveFocus()

                Keys.onDownPressed: {
                    view.incrementCurrentIndex();
                }

                Keys.onUpPressed: {
                    view.decrementCurrentIndex();
                }
            }
            ListView {
                id: view
                width: 400
                height: 460
                clip: true

                highlight: Rectangle {
                    color: "white"
                    radius: Style.radius
                }

                delegate: StartItem {}

                model: ScriptModel {
                    values: Search.search_entries(input.text)

                    onValuesChanged: view.currentIndex = 0
                }
            }
        }
    }
}
