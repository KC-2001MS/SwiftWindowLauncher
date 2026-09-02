//
//  LauncherWindowContent.swift
//  SwiftWindowLauncher
//

import SwiftUI

/// Wraps every launcher-managed window's content to capture the `openWindow`
/// action and to signal when the window's content has actually appeared.
struct LauncherWindowContent: View {
    let content: AnyView

    @Environment(\.openWindow) private var openWindow

    var body: some View {
        content
            .onAppear {
                LauncherApp.openWindowAction = openWindow
                let waiters = LauncherApp.presentationWaiters
                LauncherApp.presentationWaiters = []
                for waiter in waiters {
                    waiter.resume()
                }
            }
    }
}
