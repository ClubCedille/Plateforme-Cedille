#!/usr/bin/env python3
"""Validate club definitions and render the generated configuration consumed by k8s-shared."""

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parents[1]
CLUBS_DIR = ROOT / "clubs"
GENERATED_HEADER = "# Generated from ClubCedille/Plateforme-Cedille clubs/*.yaml. Do not edit manually.\n---\n"
GROUP_TEAM_MAP_RE = re.compile(r"(?m)^(?P<indent>\s*)groupTeamMap: '.*'$")


class ClubConfigError(Exception):
    pass


class IndentedSafeDumper(yaml.SafeDumper):
    def increase_indent(self, flow=False, indentless=False):
        return super().increase_indent(flow, False)


def dump_yaml(data) -> str:
    return yaml.dump(
        data,
        Dumper=IndentedSafeDumper,
        sort_keys=False,
        default_flow_style=False,
    )


def fail(message: str) -> None:
    raise ClubConfigError(message)


def require_mapping(value, path: str) -> dict:
    if not isinstance(value, dict):
        fail(f"{path} must be a mapping")
    return value


def require_string(value, path: str) -> str:
    if not isinstance(value, str) or not value.strip():
        fail(f"{path} must be a non-empty string")
    return value


def require_string_list(value, path: str) -> list[str]:
    if not isinstance(value, list) or any(not isinstance(item, str) or not item for item in value):
        fail(f"{path} must be a list of non-empty strings")
    return value


def load_clubs() -> list[dict]:
    paths = sorted(CLUBS_DIR.glob("*.yaml"))
    if not paths:
        fail(f"no club files found in {CLUBS_DIR}")

    clubs = []
    names = set()
    for path in paths:
        raw = yaml.safe_load(path.read_text()) or {}
        data = require_mapping(raw, str(path.relative_to(ROOT)))
        name = require_string(data.get("name"), f"{path.name}: name")
        if name != path.stem:
            fail(f"{path.name}: name must match the filename ({path.stem!r})")
        if name in names:
            fail(f"{path.name}: duplicate club name {name!r}")
        names.add(name)

        nextcloud = require_mapping(data.get("nextcloud", {}), f"{path.name}: nextcloud")
        quota = nextcloud.get("quota")
        if not isinstance(quota, int) or isinstance(quota, bool) or quota < 0:
            fail(f"{path.name}: nextcloud.quota must be a non-negative integer")
        external_sites = require_string_list(nextcloud.get("external_sites", []), f"{path.name}: nextcloud.external_sites")

        authentik = require_mapping(data.get("authentik", {}), f"{path.name}: authentik")
        extra_groups = authentik.get("extra_groups", [])
        if not isinstance(extra_groups, list):
            fail(f"{path.name}: authentik.extra_groups must be a list")
        extra_group_names = set()
        for idx, group_name in enumerate(extra_groups):
            require_string(group_name, f"{path.name}: authentik.extra_groups[{idx}]")
            if group_name in extra_group_names:
                fail(f"{path.name}: duplicate authentik extra group {group_name!r}")
            extra_group_names.add(group_name)

        forgejo = require_mapping(data.get("forgejo", {}), f"{path.name}: forgejo")
        forgejo_groups = require_mapping(forgejo.get("groups", {}), f"{path.name}: forgejo.groups")
        for group_name, organizations in forgejo_groups.items():
            require_string(group_name, f"{path.name}: forgejo.groups key")
            organizations = require_mapping(organizations, f"{path.name}: forgejo.groups.{group_name}")
            for org_name, teams in organizations.items():
                require_string(org_name, f"{path.name}: forgejo.groups.{group_name} organization")
                require_string_list(teams, f"{path.name}: forgejo.groups.{group_name}.{org_name}")

        matomo = require_mapping(data.get("matomo", {}), f"{path.name}: matomo")
        access = require_mapping(matomo.get("access", {}), f"{path.name}: matomo.access")
        for group_name, role in access.items():
            require_string(group_name, f"{path.name}: matomo.access key")
            require_string(role, f"{path.name}: matomo.access.{group_name}")

        clubs.append(
            {
                "name": name,
                "quota": quota,
                "external_sites": external_sites,
                "extra_groups": extra_groups,
                "forgejo_groups": forgejo_groups,
                "matomo_access": access,
            }
        )
    return clubs


def render_legacy_clubs(clubs: list[dict]) -> str:
    legacy = [
        {
            "name": club["name"],
            "external_sites": club["external_sites"],
            "quota": club["quota"],
        }
        for club in clubs
    ]
    return GENERATED_HEADER + dump_yaml(legacy)


def render_forgejo_group_team_map(clubs: list[dict]) -> str:
    merged: dict[str, dict[str, set[str]]] = {}
    for club in clubs:
        for group_name, organizations in club["forgejo_groups"].items():
            for org_name, teams in organizations.items():
                merged.setdefault(group_name, {}).setdefault(org_name, set()).update(teams)

    result = {
        group_name: {
            org_name: sorted(teams)
            for org_name, teams in sorted(organizations.items())
        }
        for group_name, organizations in sorted(merged.items())
    }
    return json.dumps(result, separators=(",", ":"), sort_keys=True)


def render_extra_groups(clubs: list[dict]) -> str:
    groups = sorted({group_name for club in clubs for group_name in club["extra_groups"]})
    return GENERATED_HEADER + dump_yaml(groups)


def render_matomo_access(clubs: list[dict]) -> str:
    result: dict[str, str] = {}
    for club in clubs:
        for group_name, role in club["matomo_access"].items():
            previous = result.get(group_name)
            if previous is not None and previous != role:
                fail(f"conflicting Matomo roles for {group_name!r}: {previous!r} vs {role!r}")
            result[group_name] = role
    return GENERATED_HEADER + dump_yaml(dict(sorted(result.items())))


def write_k8s_shared(k8s_shared: Path, legacy: str, group_team_map: str, extra_groups: str) -> None:
    data_dir = k8s_shared / "data"
    data_dir.mkdir(parents=True, exist_ok=True)
    (data_dir / "clubs.yaml").write_text(legacy)
    (data_dir / "authentik-extra-groups.yaml").write_text(extra_groups)

    values_path = k8s_shared / "apps/forgejo/base/forgejo.values.yaml"
    text = values_path.read_text()
    replacement = f"      groupTeamMap: '{group_team_map}'"
    updated, count = GROUP_TEAM_MAP_RE.subn(replacement, text)
    if count != 1:
        fail(f"expected exactly one groupTeamMap line in {values_path}, found {count}")
    values_path.write_text(updated)


def render_to_directory(output_dir: Path, clubs: list[dict]) -> None:
    output_dir.mkdir(parents=True, exist_ok=True)
    (output_dir / "clubs.yaml").write_text(render_legacy_clubs(clubs))
    (output_dir / "forgejo-group-team-map.json").write_text(render_forgejo_group_team_map(clubs) + "\n")
    (output_dir / "authentik-extra-groups.yaml").write_text(render_extra_groups(clubs))
    (output_dir / "matomo-access.yaml").write_text(render_matomo_access(clubs))


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true", help="validate club files without writing output")
    parser.add_argument("--output-dir", type=Path, help="render generated artifacts into this directory")
    parser.add_argument("--k8s-shared", type=Path, help="write generated files directly into a k8s-shared checkout")
    args = parser.parse_args()

    try:
        clubs = load_clubs()
        if args.output_dir:
            render_to_directory(args.output_dir, clubs)
        if args.k8s_shared:
            write_k8s_shared(
                args.k8s_shared,
                render_legacy_clubs(clubs),
                render_forgejo_group_team_map(clubs),
                render_extra_groups(clubs),
            )
        if args.check and not args.output_dir and not args.k8s_shared:
            print(f"Validated {len(clubs)} club files")
        return 0
    except (ClubConfigError, yaml.YAMLError, OSError) as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
