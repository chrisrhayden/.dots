pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick

import qs

WrapperRectangle {
    id: root

    required property PersistentProperties menuVisible

    color: Style.bgHover

    Column {
        id: items

        Repeater {
            model: {
                let list = [];
                let c = 0;
                for (let ent of DesktopEntries.applications.values) {
                    console.log(JSON.stringify(ent));
                    console.log(ent.genericName);
                    if (c < 10) {
                        list.push(ent);
                    }
                }
                return list;
            }

            WrapperRectangle {
                id: item
                required property DesktopEntry modelData

                Text {
                    text: item.modelData?.name ? item.modelData.name : "fuck"
                }
            }
        }
    }
}
