//
//  LauncherApp.swift
//  SwiftWindowLauncher
//

import SwiftUI

/// The internal SwiftUI `App` used to present SwiftUI content.
///
/// Native window chrome — the toolbar-integrated (Liquid Glass) tab bar of a
/// `TabView`, window titles from `navigationTitle`, automatic sizing, and the
/// standard app menu — is only fully provided for windows created by a real
/// SwiftUI scene. Manually constructed `NSWindow` + `NSHostingController`
/// combinations render fallback appearances instead. `WindowLauncher` therefore
/// boots this `App` with `WindowGroup` scenes rather than building windows by hand.
struct LauncherApp: App {
    @NSApplicationDelegateAdaptor(LauncherAppDelegate.self) private var appDelegate

    /// Whether `LauncherApp.main()` has been called.
    @MainActor static var booted = false

    /// The content of the first window, stashed before `LauncherApp.main()` is called.
    @MainActor static var firstContent: AnyView = AnyView(EmptyView())

    /// Contents of additional windows, keyed by the value passed to `openWindow`.
    @MainActor static var extraContents: [UUID: AnyView] = [:]

    /// The `openWindow` action captured from a live window's environment.
    /// Used to open additional windows programmatically.
    @MainActor static var openWindowAction: OpenWindowAction?

    /// Continuations awaiting the next window presentation
    /// (resumed from a window content's `onAppear`).
    @MainActor static var presentationWaiters: [UnsafeContinuation<Void, Never>] = []

    var body: some Scene {
        WindowGroup {
            LauncherWindowContent(content: Self.firstContent)
        }
        .defaultLaunchBehavior(.presented)
        .restorationBehavior(.disabled)

        WindowGroup(for: UUID.self) { $id in
            if let id, let content = LauncherApp.extraContents[id] {
                LauncherWindowContent(content: content)
            }
        }
        .restorationBehavior(.disabled)
    }
}
