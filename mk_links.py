#!/usr/bin/env python3


from pathlib import Path
import tomllib
import os


config_dir = Path("~/.dots/").expanduser()
config_file = Path("~/.dots/links.toml").expanduser()


def expand_path(path: Path) -> list[Path]:
    return [p for p in path.parent.glob(path.name)]


class Link:
    from_paths: list[Path]
    to_paths: list[Path]

    def __init__(self, obj: dict):
        assert obj["from"]
        assert obj["to"]

        from_path = config_dir.joinpath(obj["from"])
        from_paths = expand_path(from_path)
        to_path = Path(obj["to"]).expanduser()
        to_paths = []

        if len(from_paths) > 1:
            for f in from_paths:
                to_paths.append(to_path.joinpath(f.name))
        else:
            to_paths.append(to_path)

        self.from_paths = from_paths
        self.to_paths = to_paths


def get_all_links(config: dict) -> list[Link]:
    assert config != None
    assert config["all"]

    all_links: list[Link] = []
    for link in config["all"].values():
        all_links.append(Link(link))

    return all_links


def get_config() -> dict:
    config = None

    with open(config_file, "rb") as fd:
        config = tomllib.load(fd)

    assert config != None
    assert config["all"]

    return config


def mk_link(link: Link):
    assert len(link.from_paths) == len(link.to_paths)
    for idx in range(len(link.from_paths)):
        from_path = link.from_paths[idx]
        to_path = link.to_paths[idx]

        if to_path.is_symlink() or to_path.exists():
            print(f"{to_path} exists")
        else:
            print(f"{from_path} -> {to_path}")
            os.symlink(from_path, to_path)


def mk_links(links: list[Link]):
    for l in links:
        mk_link(l)


def run():
    """"""
    config = get_config()
    all_links = get_all_links(config)
    mk_links(all_links)


if __name__ == "__main__":
    run()
