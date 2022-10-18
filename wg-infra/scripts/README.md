# Infrastructure Scripts

The scripts in this directory are used by the Infrastructure WG to perform common actions.  Descriptions and
usage for each command is included below.

Most scripts in this directory rely on the [1Password CLI](https://developer.1password.com/docs/cli/get-started/)
working and being appropriately configured.  While running these scripts 1Password may prompt for authorization.

## `new-npm-package`

### Details

Creates or claims a new npm package in the `@electron` scope for usage with CFA. Creates the npm package if
it does not exist and then moves it to the `cfa` team and revokes all other users access before finally
enforcing 2FA publishes on the package.

### Usage

```bash
# Create or claim the @electron/get package
new-npm-package get
```
