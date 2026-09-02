//
//  LauncherAppDelegate.swift
//  SwiftWindowLauncher
//

import AppKit

/// The application delegate shared by both launch paths (installed through
/// `@NSApplicationDelegateAdaptor` on the SwiftUI path, and assigned directly
/// to `NSApplication.delegate` on the AppKit path).
///
/// Bundle-less executables launched from a terminal start as background
/// processes, so their windows can appear behind the frontmost app. The
/// documented, event-driven place to fix this is `applicationDidFinishLaunching`:
/// once the app is active, any window it presents comes to the front — no
/// timing assumptions needed.
final class LauncherAppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.activate(ignoringOtherApps: true)
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }

    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        MainActor.assumeIsolated {
            if LauncherLifecycle.isInExitGuard {
                NSApp.stop(nil)
                return .terminateCancel
            }
            return .terminateNow
        }
    }
}
