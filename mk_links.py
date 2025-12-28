#!/usr/bin/env python3


from dataclasses import dataclass
from pathlib import Path
import tomllib
import os


config_dir = Path("~/.dots/").expanduser()
config_file = Path("~/.dots/links.toml").expanduser()


@dataclass
class Link:
    from_path: Path
    to_path: Path


def mk_link(obj: dict>) -> Link:
    assert obj["from"]
    assert obj["to"]

    if obj["from"].ends_with("*"):
        # expand *
    f = Path(link["from"])
    from_path = config_dir.joinpath(f)
   
    to_path = Path(link["to"]).expanduser()

    Link(from_path=from_path, to_path=t)

def get_all_links(config: dict) -> list[Link]:
    assert config != None
    assert config["all"]

    all_links: list[Link] = []
    for link in config["all"].values():
       all_links.append()
    return all_links


def get_config() -> dict:
    config = None

    with open(config_file, "rb") as fd:
        config = tomllib.load(fd)

    assert config != None
    assert config["all"]

    return config


def print_links(links: list[Link]):
    for l in links:
        print(f"{l.from_path} -> {l.to_path}")


def mk_links(links: list[Link]):
    for l in links:
        if l.to_path.is_symlink() or l.to_path.exists():
            print(f"{l.to_path} exists")
        else:
            print(f"{l.from_path} -> {l.to_path}")
            os.symlink(l.from_path, l.to_path)


def run():
    """"""
    config = get_config()
    all_links = get_all_links(config)
    mk_links(all_links)


if __name__ == "__main__":
    run()
