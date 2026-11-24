# Club definitions

Each file in this directory defines one club and the cross-platform configuration
derived from it.

The filename must match the `name` field. Adding a club means adding one file.

## Schema

```yaml
name: lanets

nextcloud:
  quota: 3000                # GiB
  external_sites:
    - planka

authentik:
  extra_groups:              # optional; club-<name> and exec-<name> are implicit
    - matomo-lanets

forgejo:
  groups:                    # Forgejo OIDC groupTeamMap entries
    club-lanets:
      Lan_ETS:
        - Members
    exec-lanets:
      Lan_ETS:
        - Owners

matomo:
  access:                    # optional group -> Matomo role
    club-lanets: view
    exec-lanets: admin
```

## Generated outputs

`scripts/render_club_configs.py` validates these files and renders:

- `data/clubs.yaml` for k8s-shared (Nextcloud quotas and external sites)
- `data/authentik-extra-groups.yaml` for Terraform
- the Forgejo `groupTeamMap` value in `apps/forgejo/base/forgejo.values.yaml`
- `forgejo-group-team-map.json`, `authentik-extra-groups.yaml` and
  `matomo-access.yaml` for inspection/other consumers

The k8s-shared copies are generated. Do not edit them by hand.

## Workflow

The `Render club configuration` workflow validates changes on pull requests and,
on `main`, renders the k8s-shared files and opens/updates a PR there. It requires
a `K8S_SHARED_TOKEN` repository secret with permission to write to
`ClubCedille/k8s-shared`.

## Identity data

Do not store user identities or passwords here. Define groups and permissions in
this repository; manage user-to-group membership in Authentik/LDAP or another
private identity source.
