# GitHub

## Controlling Access

GitHub repository access and permissions are controlled via the yaml file in [electron/.permissions](https://github.com/electron/.permissions).  Existing access permissions can be viewed there.

## Organization Owners

Maintainers are granted ownership based on a need-focused approval process.

All approved owners shall be listed below:

| Name | GitHub Username | Date Granted |
|------|-----------------|--------------|
| Charles Kerr | @ckerr | 11-17-2020 |
| Shelley Vohr | @codebytere | 11-17-2020 |
| Jacob Groundwater | @groundwater | 11-17-2020 |
| John Kleinschmidt | @jkleinsc | 11-17-2020 |
| Samuel Attard | @MarshallOfSound | 11-17-2020 |

Adding and removing people from this list requires good reasoning and a vote from the Administrative Working Group.

The process to make a change to the list below is outlined in the [Administrative Working Group Documentation](../../../wg-administrative/github-ownership-access.md).  If the request is approved a member of the Administrative Working Group shall make a pull request to this file to update the above list.

## Repository Administrators

There is currently no direct-grant of "Admin" permissions for repositories.  To perform a task that requires Admin permissions, mention the @owners GitHub team when submitting a pull request to `.permissions`.

## Repository Write Access

All [maintainers](../../../charter/README.md#definitions) are granted "Write" permissions to all
**public** `electron/*` repositories that their working groups are responsible for with the following exceptions:

* [`electron/archaeologist`](https://github.com/electron/archaeologist)
* [`electron/debian-sysroot-image-creator`](https://github.com/electron/debian-sysroot-image-creator)
* [`electron/electron`](https://github.com/electron/electron)
* [`electron/fiddle`](https://github.com/electron/fiddle)
* [`electron/nightlies`](https://github.com/electron/nightlies)
* [`electron/trop`](https://github.com/electron/trop)
* [`electron/update.electronjs.org`](https://github.com/electron/update.electronjs.org)

All Working Group Members are granted "Write" permissions to the **private** repositories that their group is responsible for, and the working group can decide on access to nonmembers. This is documented in the `repos.md` file in each `wg-*` directory in this Governance repository.

Although "Write" access may be granted to the repository this does **not** implicitly grant `main` / Protected Branch rights. They shall be determined by the Working Group that owns each repository but as a general policy, all repositories should have their `main` branch set as a Protected Branch.

If a repository has multiple Working Group stakeholders, access will be determined by a vote from the chairs of _all_ working groups. Any chair may abstain.  The vote must be at least 2/3 of participating chairs.

## Repository Read Access

Repositories in the Electron Organization should be public / open-source by default. Read access should never have to be granted explicitly to a repository.  Some sensitive repositories can be private but they must have a good reason for being kept private.
