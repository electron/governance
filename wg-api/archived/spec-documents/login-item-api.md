# `app.{set|get}LoginItemSettings(settings)`

## Summary

`app.setLoginItemSettings(settings)` and `app.getLoginItemSettings(settings)` will be updated on macOS 13 to use a single streamlined underlying API on both Mac App Store and regular macOS builds. This will remove several configuration and settings options, including `openAsHidden` in `app.setLoginItemSettings` and `wasOpenedAtLogin` and `wasOpenedAsHidden` in `app.getLoginItemSettings`.

This will simplify the underlying logic in accordance to the APIs apple has outlined for usage and improve parity between MAS and non-MAS builds. This will also allow developers to register app service objects, launch daemons, and login item services to launch on startup.

As the new APIs were not introduced until 10.13, we will support the older APIs until we drop support for macOS 12.

## Platforms

**macOS**

## Impetus

At present, Electron uses `LSSharedFileList` APIs to register applications as login items. These APIs have been deprecated since 10.11, and have not worked for several years on sandboxed Mac App Store builds. Chromium is also slowly [removing usage upstream](https://chromium-review.googlesource.com/c/chromium/src/+/3997795), requiring us to float increasingly deprecated code. As of Ventura, several key aspects of login item settings, namely `openAsHidden`, also no longer work.

In macOS 13, Apple introduced [`SMAppService`](https://developer.apple.com/documentation/servicemanagement/smappservice?language=objc) to take the place of the APIs they phased out. This service is used to register and control `LoginItems`, `LaunchAgents`, and `LaunchDaemons` as helper executables for apps.

## API Design

The new methods will adhere to the following semantics:

```md
### `app.setLoginItemSettings(settings)` _macOS_ _Windows_

* `settings` Object
  * `openAtLogin` boolean (optional) - `true` to open the app at login, `false` to remove
    the app as a login item. Defaults to `false`.
  * `openAsHidden` boolean (optional) _macOS_ _Deprecated_ - `true` to open the app as hidden. Defaults to `false`. The user can edit this setting from the System Preferences so `app.getLoginItemSettings().wasOpenedAsHidden` should be checked when the app is opened to know the current value. This setting is not available on [MAS build
s][mas-builds] or on macOS 13 and up.
  * `type` string (optional) _macOS_ - The type of service to add as a login item. Defaults to `mainAppService`. Only available on macOS 13 and up.
    * `mainAppService` - The primary application.
    * `agentService` - The property list name for a launch agent. The property list name must correspond to a property list in the app’s `Contents/Library/LaunchAgents` directory.
    * `daemonService` string (optional) _macOS_ - The property list name for a launch agent. The property list name must correspond to a property list in the app’s `Contents/Library/LaunchDaemons` directory.
    * `loginItemService` string (optional) _macOS_ - The property list name for a login item service. The property list name must correspond to a property list in the app’s `Contents/Library/LoginItems` directory.
  * `serviceName` string (optional) _macOS_ - The name of the service. Required if `type` is non-default. Only available on macOS 13 and up.
  * `path` string (optional) _Windows_ - The executable to launch at login.
    Defaults to `process.execPath`.
  * `args` string[] (optional) _Windows_ - The command-line arguments to pass to
    the executable. Defaults to an empty array. Take care to wrap paths in
    quotes.
  * `enabled` boolean (optional) _Windows_ - `true` will change the startup approved registry key and `enable / disable` the App in Task Manager and Windows Settings.
    Defaults to `true`.
  * `name` string (optional) _Windows_ - value name to write into registry. Defaults to the app's AppUserModelId().
```

```md
### `app.getLoginItemSettings([options])` _macOS_ _Windows_

* `options` Object (optional)
  * `type` string (optional) _macOS_ - Can be one of `mainAppService`, `agentService`, `daemonService`, or `loginItemService`. Defaults to `mainAppService`. Only available on macOS 13 and up. See [app.setLoginItemSettings](app.md#appsetloginitemsettingssettings-macos-windows) for more information about each type.
  * `serviceName` string (optional) _macOS_ - The name of the service. Required if `type` is non-default. Only available on macOS 13 and up.
  * `path` string (optional) _Windows_ - The executable path to compare against. Defaults to `process.execPath`.
  * `args` string[] (optional) _Windows_ - The command-line arguments to compare against. Defaults to an empty array.

If you provided `path` and `args` options to `app.setLoginItemSettings`, then you
need to pass the same arguments here for `openAtLogin` to be set correctly.

Returns `Object`:

* `openAtLogin` boolean - `true` if the app is set to open at login.
* `openAsHidden` boolean _macOS_ _Deprecated_ - `true` if the app is set to open as hidden at login. This does not work on macOS 13 and up.
* `wasOpenedAtLogin` boolean _macOS_ _Deprecated_ - `true` if the app was opened at login automatically. This setting is not available on [MAS builds][mas-builds] or on macOS 13 and up.
* `wasOpenedAsHidden` boolean _macOS_ _Deprecated_ - `true` if the app was opened as a hidden login item. This indicates that the app should not open any windows at startup. This setting is not available on [MAS builds][mas-builds] or on macOS 13 and up.
* `restoreState` boolean _macOS_ _Deprecated_ - `true` if the app was opened as a login item that should restore the state from the previous session. This indicates that the app should restore the windows that were open the last time the app was closed. This setting is not available on [MAS builds][mas-builds] or on macOS 13 and up.
* `status` string _macOS_ - can be one of `not-registered`, `enabled`, `requires-approval`, or `not-found`.
* `executableWillLaunchAtLogin` boolean _Windows_ - `true` if app is set to open at login and its run key is not deactivated. This differs from `openAtLogin` as it ignores the `args` option, this property will be true if the given executable would be launched at login with **any** arguments.
* `launchItems` Object[] _Windows_
  * `name` string _Windows_ - name value of a registry entry.
  * `path` string _Windows_ - The executable to an app that corresponds to a registry entry.
  * `args` string[] _Windows_ - the command-line arguments to pass to the executable.
  * `scope` string _Windows_ - one of `user` or `machine`. Indicates whether the registry entry is under `HKEY_CURRENT USER` or `HKEY_LOCAL_MACHINE`.
  * `enabled` boolean _Windows_ - `true` if the app registry key is startup approved and therefore shows as `enabled` in Task Manager and Windows settings.
```

If an app was set as a login item with the previous API, disabling the app as a login item will disable it with the old API. Enabling it again will use the new API. Additionally, it will continue to report login item status via old API until the app has been updated to use the new API.

## Rollout Plan

This will live in Electron `v28.0.0` and beyond.
