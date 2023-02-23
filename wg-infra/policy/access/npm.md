# NPM

> ⚠️ This document currently described an ideal reality, not what is currently configured.  It will either be updated or implemented at some point in the future ⚠️ 

## Access to the "electron" Organization on NPM

All [maintainers](../../../charter/README.md#definitions) are entitled to be a "member" of the electron organization on NPM.  Permissions on on the `npm` org are managed by the Security Working Group.  Head over to the `#wg-security` channel on Slack to ask to be added.  By default, new maintainers will be added to the `developers` team. At a minimum a maintainer's `npm` account must have `auth-and-write` 2FA configured.

### NPM Teams

There are three teams on NPM, `developers`, `cfa`, `electron`.

* `developers` will have `read` access to all packages with the exception of the "electron" package.
* `cfa` will have `read/write` on all packages with the exception of the "electron" package.
* `electron` will have `read/write` on **only** the "electron" package.

The only user in the `electron` team will be the "electron-bot" user.  As such the only user with permission to publish the `electron` package should always be "electron-bot".  Publishing of this package will be triggered through `sudowoodo`.

The only user in the `cfa` team will be the "electron-cfa" user.  As such the only user with permission to publish packages in the `electron` organization should be "electron-cfa".  As no humans have publish rights to any of these packages they should all be configured with `semantic-release` and the `@electron/semantic-release-npm-cfa` plugin.  For information on how to configure this plugin for use with a new package head over to [`continuousauth/web`](https://github.com/continuousauth/web).

## Human access to individual packages

No human should ever have publish rights on their personal `npm` account to any Electron NPM package.

## `electron-bot` credentials

Credentials for the "electron-bot" user will be stored on the 1-Password, access to these credentials will be controlled by the Releases Working Group.  Access to the 2FA secret for this account will be administered separately to the username/password as most of the Releases Working Group needs the 2FA secret to approve releases.

## `electron-cfa` credentials

Credentials for the "electron-cfa" user will be stored on the 1-Password, access to these credentials will be controlled by the Ecosystem Working Group.  Access to the 2FA secret for this account will be administered separately to the username/password as most of the Ecosystem Working Group needs the 2FA secret to approve releases.
