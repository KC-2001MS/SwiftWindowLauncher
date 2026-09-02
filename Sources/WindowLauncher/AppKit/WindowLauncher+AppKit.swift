//
//  WindowLauncher+AppKit.swift
//  SwiftWindowLauncher
//

import AppKit

extension WindowLauncher {
    /// Whether the AppKit-side event loop and lifecycle hooks are set up.
    @MainActor private static var appKitBooted = false

    /// The delegate for AppKit-style launches (`NSApplication.delegate` is weak,
    /// so keep a strong reference here). SwiftUI-style launches get the same
    /// delegate through `@NSApplicationDelegateAdaptor` instead.
    @MainActor private static let appKitDelegate = LauncherAppDelegate()

    /// Launches a window containing the specified AppKit `NSViewController`.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to host.
    ///   - title: The window title.
    ///
    /// The window is created with `NSWindow(contentViewController:)`, so
    /// controller-driven window features — `NSToolbar` customization,
    /// `NSTabViewController` with `tabStyle = .toolbar`, and so on — integrate
    /// with the window the same way they do in a regular AppKit app.
    ///
    /// - Note: This method starts the application's main run loop; it never returns.
    @MainActor
    public func launch(
        _ viewController: NSViewController,
        title: String = ""
    ) {
        presentAppKitWindow(viewController, title: title)
        bootAppKitAppIfNeeded()
        NSApplication.shared.run()
    }

    /// Launches a window containing the specified AppKit `NSViewController` from
    /// an async context and returns once the window is on screen.
    ///
    /// The caller can continue its work regardless of the window's state — the
    /// SwiftUI overloads and this one share the same lifecycle: the window stays
    /// open after the caller's `main` returns, and the process terminates when
    /// every window has been closed. Each subsequent call opens an additional window.
    @MainActor
    public func launch(
        _ viewController: NSViewController,
        title: String = ""
    ) async {
        presentAppKitWindow(viewController, title: title)
        guard !Self.appKitBooted else { return }
        bootAppKitAppIfNeeded()
        
        RunLoop.main.perform {
            MainActor.assumeIsolated {
                guard !LauncherLifecycle.isInExitGuard else { return }
                NSApplication.shared.run()
            }
        }
    }

    /// Launches a new window containing the specified AppKit `NSView`.
    ///
    /// - Parameter nsview: The `NSView` instance to be displayed in the new window.
    ///
    /// - Note: This method starts the application's main run loop; it never returns.
    @MainActor
    public func launch(
        _ nsview: NSView
    ) {
        let viewController = NSViewController()
        viewController.view = nsview
        launch(viewController)
    }

    /// Launches a new window containing the specified AppKit `NSView` from an
    /// async context and returns once the window is on screen.
    ///
    /// See the `NSViewController`-based async overload for the lifecycle details.
    @MainActor
    public func launch(
        _ nsview: NSView
    ) async {
        let viewController = NSViewController()
        viewController.view = nsview
        await launch(viewController)
    }

    /// Installs the app delegate and the exit guard for AppKit-style launches.
    /// Gives the AppKit path the same lifecycle as the SwiftUI path:
    /// windows outlive the caller's `main`, and closing every window
    /// terminates the process.
    @MainActor
    private func bootAppKitAppIfNeeded() {
        guard !Self.appKitBooted else { return }
        Self.appKitBooted = true
        let app = NSApplication.shared
        app.setActivationPolicy(.regular)
        app.delegate = Self.appKitDelegate
        atexit(windowLauncherExitGuard)
    }

    /// Hosts an AppKit view controller in a window and shows it.
    @MainActor
    private func presentAppKitWindow(_ viewController: NSViewController, title: String) {
        let newWindow = NSWindow(contentViewController: viewController)
        newWindow.styleMask.insert([.closable, .resizable])
        newWindow.title = title
        newWindow.minSize = NSSize(width: 200, height: 200)
        newWindow.center()
        newWindow.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
}
