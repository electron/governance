# NPM

## Access to the "electron" Organization on NPM

Only two accounts are permitted access to the `@electron` org on NPM. Specifically `electron-cfa` and `electronhq`.

### NPM Teams

There are two teams on NPM, `developers`, and`cfa`.

* `developers` will have `read` access to all packages with the exception of the "electron" package.
* `cfa` will have `read/write` on all packages with the exception of the "electron" package.

The only user in the `cfa` team will be the "electron-cfa" user.  As such the only user with permission to publish packages in the `electron` organization should be "electron-cfa".  As no humans have publish rights to any of these packages they should all be configured with `semantic-release` and the `@electron/semantic-release-npm-cfa` plugin.  For information on how to configure this plugin for use with a new package head over to [`continuousauth/web`](https://github.com/continuousauth/web).

## Access to the "electron" package on NPM

The core `electron` package is the one exception to other NPM package rules, namely it is the only old package that we won't ever move into the `@electron` scope and it's the only package that won't be governed by CFA. Instead this package is limited to a third user `electron-nightly` whose only permission is to publish this package. Publishing of this package will be triggered through `sudowoodo`.

At no point should any human have access to the `electron` NPM package.

## Human access to individual packages

No human should ever have publish rights on their personal `npm` account to any Electron NPM package.

## New Packages

All new packages should be created by the Infra Working Group in the `@electron` scope per the access restrictions outlined above.

## Credentials

### `electronhq` credentials

Credentials for the "electronhq" user will be stored on the 1-Password, access to these credentials will be controlled by the Infra Working Group. No other working group or user will be granted access to this account.

### `electron-cfa` credentials

Credentials for the "electron-cfa" user will be stored on the 1-Password, access to these credentials will be controlled by the Infra Working Group.  Access to the 2FA secret for this account will be administered separately to the username/password as most of the Ecosystem Working Group needs the 2FA secret to approve releases.

### `electron-nightly` credentials

Credentials for the "electron-nightly" user will be stored on the 1-Password, access to these credentials will be controlled by the Infra Working Group.  Access to the 2FA secret for this account will be administered separately to the username/password as most of the Releases Working Group needs the 2FA secret to approve releases.
