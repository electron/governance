# NPM Packages

## Maintainer Access

Maintainer access to npm is governed by the [npm access policy](./access/npm.md).

## Package Security

NPM packages that Electron is responsible for must meet the following requirements:

* Packages **must** be published from CI systems only
* Automatic release credentials **must** be restricted to the default branch
  * Per the [GitHub policy](github.md) this default branch must be protected as this is an eligible repository
* Publishing system
  * Packages **should** be publised via an [OIDC Trusted Publisher](https://docs.npmjs.com/trusted-publishers)
  * Packages existing before August 9th 2025 **may** be published via [Continuous Auth](https://github.com/continuousauth/web)
* Package Settings
  * Packages **must** have a single owner
    * Packages using OIDC Trusted Publisher's **must** be owned by the `electronhq` account
    * Pacakes using Continuous Auth **must** be owned by the `electron-cfa` account

## Dependency Restrictions

* Dependencies **must** be locked using an appropriate package manager lockfile
  * Our preferred package manager is currently `yarn@4`
* Socket.DEV **must** be configured on your repository
  * Socket.DEV **must** be a required check
  * Dependencies that fail our Socket.dev policies are not permitted under any circumstances, for issues please reach out to #wg-infra and cc @wg-security
* Repositories are **not** allowed to accept external contributions that touch the package manifest or the lockfile
* The goal should be to **minimize** dependencies
  * Aim to use node internals when possible
  * Aim to inline small packages / single functions when possible

## Exceptions

Exceptions to the above policy can be requested in #wg-infra and current exceptions are recorded outside of this repository.
