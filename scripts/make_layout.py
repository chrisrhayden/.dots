#!/usr/bin/env python

from os import (environ, path)
import sys
import json
import subprocess
import argparse


def eprint(message):
    """" just print to stderr """
    print(message, file=sys.stderr)


def parse_args():
    """ set up cli args """

    parser = argparse.ArgumentParser(description="add a layout to a workspace")

    parser.add_argument("--layout", "-l",
            help="the layout type to use",
            choices=["dev", "info", "youtube"],
    )

    parser.add_argument("--workspace", "-w",
            help="a workspace to use instead of the focused one",
            type=int,
    )

    parser.add_argument("--start-up", "-s",
        help="make the start up layouts",
        action="store_true"
    )

    return parser.parse_args()


def spawn_cmd(cmd):
    """ spawn a process to outlive this program """
    subprocess.Popen(cmd)


def run_cmd(cmd):
    """
    wait for a cmd to finish and return the output
    or print errors to stderr

    this will decode the output as its easier to do it here
    """

    cmd = subprocess.run(cmd, capture_output=True)

    if cmd.returncode > 0:
        eprint(f"Error from {cmd}: {cmd.stderr}")
        return False

    return cmd.stdout.decode()


def get_focused_workspace():
    """ get the focused workspace number """

    # it looks like this returns good json unlike `i3-save-tree`
    trees = run_cmd(["i3-msg", "-t", "get_workspaces"])

    if not trees:
        eprint("did not get workspace trees from i3-msg")
        return False

    trees = json.loads(trees)

    workspace_num = str()

    for workspace in trees:
        # both need to be true
        # or it could be another visible but unfocused workspace
        if workspace["visible"] and workspace["focused"]:
            workspace_num = workspace["num"]
            break

    if not workspace_num:
        eprint("did not get a workspace number")
        return False

    return workspace_num


def make_layout(current_workspace, workspace_num, config):
    layout_path = config["layout_path"]

    layout_msg = ["i3-msg"]

    if current_workspace != workspace_num:
        layout_msg.append(
            f"workspace --no-auto-back-and-forth {workspace_num}; "
            f"append_layout {layout_path}"
        )
    else:
        layout_msg.append(f"append_layout {layout_path}")

    if not run_cmd(layout_msg):
        return False

    for app in config["applications"]:
        spawn_cmd(app)

    return True


def main(layout_configs, default_workspaces):
    success = False

    args = parse_args()

    current_workspace = get_focused_workspace()

    if args.start_up:
        for (layout, workspace) in default_workspaces.items():

            success = make_layout(current_workspace, workspace, layout_configs[layout])

            if not success:
                break

    else:
        if not args.layout:
            success = False
        else:

            # argparse will make sure only valid layouts get this far
            config = layout_configs[args.layout]

            if args.workspace:
                workspace = args.workspace
            else:
                workspace = current_workspace

            success = make_layout(current_workspace, workspace, config)

    return success


if __name__ == "__main__":
    if not environ["HOME"]:
        eprint("HOME env variable not set")
        exit(1)

    default_workspaces = {
        "dev": "2",
        "info": "1",
        "youtube": "7"
    }

    youtube_applications = [
        ["firefox", "--new-window", "https://www.youtube.com/"]
    ]

    youtube_config = {
        "layout_path": path.join(environ["HOME"], ".config/i3/layouts/youtube.jsonc"),
        "applications": youtube_applications,
    }

    info_applications = [
        [
            "alacritty", "--class", "info_big_term,info_big_term",
            "--working-directory", environ["HOME"],
        ],
        [
            "alacritty", "--class", "info_medium_term,info_medium_term",
            "--working-directory", environ["HOME"],
        ],
        [
            "alacritty", "--class", "info_small_term,info_small_term",
            "--working-directory", environ["HOME"],
        ]
    ]

    info_config = {
        "layout_path": path.join(environ["HOME"], ".config/i3/layouts/info.jsonc"),
        "applications": info_applications,
    }

    dev_applications = [
        ["firefox"],
        [
            "alacritty", "--class", "dev_small_term,dev_small_term",
            "--working-directory", environ["HOME"]],
        [
            "alacritty", "--class", "dev_big_term,dev_big_term",
            "--working-directory", environ["HOME"]
        ],
    ]

    dev_config = {
        "layout_path": path.join(environ["HOME"], ".config/i3/layouts/dev.jsonc"),
        "applications": dev_applications,
    }

    layout_configs = {
        "dev": dev_config,
        "info": info_config,
        "youtube": youtube_config,
    }


    if not main(layout_configs, default_workspaces):
        exit(1)

    exit(0)
