import { bind } from "astal"
import Hyperland from "gi://AstalHyprland"

type WData = {
    monitor: string
}

function mk_class_name(monitor: Hyperland.Monitor,
    ws: Hyperland.Workspace, fw: Hyperland.Workspace): string[] {

    let class_names = ["can-hover"]

    if (ws === fw) {
        class_names.push("focused")
    } else if (ws === monitor.get_active_workspace()) {
        class_names.push("active")
    }

    return class_names
}

export function WorkSpace({ monitor }: WData): JSX.Element {
    const hyperland = Hyperland.get_default()

    const hypr_mons = hyperland.get_monitors()

    let cur_mon_name: string | null = null
    let cur_mon: Hyperland.Monitor | null = null

    for (let m of hypr_mons) {
        const m_name = m.get_name()

        if (m_name === monitor) {
            cur_mon_name = m_name
            cur_mon = m
            break
        }
    }

    if (!cur_mon_name || !cur_mon) {
        throw new Error("could not get monitor from hyperland")
    }

    return <box cssName="workspaces" >
        {
            bind(hyperland, "workspaces").as(wss => wss
                .sort((a, b) => a.id - b.id)
                .filter(ws => ws.monitor.get_name() === cur_mon_name)
                .map(ws => (
                    <button cssClasses={bind(hyperland, "focusedWorkspace")
                        .as(fw => mk_class_name(cur_mon, ws, fw))}
                        onClicked={() => ws.focus()}
                    >
                        {ws.id}
                    </button>))
            )
        }
    </box >
}
