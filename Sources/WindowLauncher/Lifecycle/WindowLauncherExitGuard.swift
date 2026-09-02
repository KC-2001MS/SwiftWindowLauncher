//
//  WindowLauncherExitGuard.swift
//  SwiftWindowLauncher
//

import AppKit

/// Invoked right before the process exits (i.e. after the caller's `main` has
/// finished). While launcher-managed windows are still open, this hands the
/// main thread to AppKit's own event loop so the windows stay on screen and
/// interactive. Once every window is closed, the resulting terminate request is
/// converted into `stop` by the delegate (see `LauncherAppDelegate`), `run()`
/// returns, and the pending exit completes.
///
/// This is what lets callers run their code to completion — `launch` returns
/// right after presenting — while the UI itself lives until the user closes it.
/// Registered via `atexit` by both the SwiftUI and the AppKit boot paths.
func windowLauncherExitGuard() {
    guard Thread.isMainThread else { return }
    MainActor.assumeIsolated {
        let app = NSApplication.shared
        guard app.windows.contains(where: { $0.isVisible || $0.isMiniaturized }) else {
            return
        }
        LauncherLifecycle.isInExitGuard = true
        app.run()
    }
}
