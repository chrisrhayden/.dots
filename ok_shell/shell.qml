import QtQuick
import Quickshell

import "modules"

import build

ShellRoot {

    Binding {
        target: Search
        property: "entries"
        value: DesktopEntries.applications.values
    }

    Bar {}
}
