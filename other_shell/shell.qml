import Quickshell
import QtQuick

import "modules"

Scope {
    Variants {
        model: Quickshell.screens

        Bar {
            screen: modelData
        }
    }
}
