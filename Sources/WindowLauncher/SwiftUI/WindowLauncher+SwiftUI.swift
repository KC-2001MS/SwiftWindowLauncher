//
//  WindowLauncher+SwiftUI.swift
//  SwiftWindowLauncher
//

import SwiftUI

extension WindowLauncher {
    /// Launches a window containing the given SwiftUI view.
    ///
    /// - Parameters:
    ///   - view: A closure returning the SwiftUI `View` to display.
    ///   - title: The window title. Pass an empty string to let the content
    ///     (e.g. `navigationTitle`) decide.
    ///
    /// - Note: This method starts the application's main run loop; it never returns.
    @MainActor
    public func launch<Content: View>(
        _ view: () -> Content,
        title: String = ""
    ) {
        LauncherApp.booted = true
        LauncherApp.firstContent = titledContent(view(), title: title)
        bootSwiftUIApp()
    }

    /// Launches a window containing the given SwiftUI view.
    ///
    /// - Parameters:
    ///   - view: An autoclosure returning the SwiftUI `View` to display.
    ///   - title: The window title. Pass an empty string to let the content decide.
    ///
    /// - Note: This method starts the application's main run loop; it never returns.
    @MainActor
    public func launch<Content: View>(
        _ view: @autoclosure () -> Content,
        title: String = ""
    ) {
        LauncherApp.booted = true
        LauncherApp.firstContent = titledContent(view(), title: title)
        bootSwiftUIApp()
    }

    /// Launches a window containing the given SwiftUI view from an async context
    /// and returns once the content is on screen.
    ///
    /// The caller can continue its work regardless of the window's state; the
    /// window stays open, and each subsequent call opens an additional window.
    /// After the caller's `main` returns, the process keeps running until every
    /// window has been closed (see `windowLauncherExitGuard`).
    ///
    /// The first call boots the app's run loop in the background — without
    /// blocking the current main-actor task, so RealityKit-backed views (such as
    /// Swift Charts' `Chart3D`) also render. The compiler selects this overload
    /// automatically in async contexts.
    @MainActor
    public func launch<Content: View>(
        _ view: () -> Content,
        title: String = ""
    ) async {
        let content = titledContent(view(), title: title)
        if LauncherApp.booted {
            let id = UUID()
            LauncherApp.extraContents[id] = content
            LauncherApp.openWindowAction?(value: id)
        } else {
            LauncherApp.booted = true
            LauncherApp.firstContent = content
            RunLoop.main.perform {
                MainActor.assumeIsolated {
                    self.bootSwiftUIApp()
                }
            }
        }
        // ウィンドウの内容が実際に表示される(onAppear)まで待ってから戻る
        await withUnsafeContinuation { continuation in
            LauncherApp.presentationWaiters.append(continuation)
        }
    }

    /// Launches a window containing the given SwiftUI view from an async context
    /// and returns once the content is on screen.
    ///
    /// See the closure-based async overload for details.
    @MainActor
    public func launch<Content: View>(
        _ view: @autoclosure () -> Content,
        title: String = ""
    ) async {
        await launch(view, title: title)
    }

    // MARK: - 内部処理

    /// Boots the internal SwiftUI app.
    ///
    /// Bundle-less executables (plain SwiftPM binaries launched from a terminal)
    /// don't get the `.regular` activation policy automatically, which can leave
    /// the app in the background with its windows never shown. Set the policy
    /// explicitly before entering the app's run loop.
    @MainActor
    private func bootSwiftUIApp() {
        NSApplication.shared.setActivationPolicy(.regular)
        // 呼び出し側の処理がすべて終わって main が return しても、開いている
        // ウィンドウが残っている間はプロセスを終了させない(windowLauncherExitGuard 参照)
        atexit(windowLauncherExitGuard)
        LauncherApp.main()
    }

    /// Applies the window title to the view when one is specified.
    @MainActor
    private func titledContent<Content: View>(_ view: Content, title: String) -> AnyView {
        if title.isEmpty {
            return AnyView(view)
        }
        return AnyView(view.navigationTitle(title))
    }
}
