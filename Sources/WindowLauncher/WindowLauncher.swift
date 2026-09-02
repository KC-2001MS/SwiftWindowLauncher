// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

/// A utility class for launching windows containing SwiftUI views or AppKit views.
///
/// The two presentation paths are fully independent — neither framework hosts
/// the other at the window level, so each gets its complete native behavior:
///
/// - **SwiftUI** (`SwiftUI/`): content is presented through a real SwiftUI
///   `WindowGroup` scene, providing native window chrome such as the
///   toolbar-integrated tab bar of a `TabView` and `navigationTitle` handling.
/// - **AppKit** (`AppKit/`): content is presented through
///   `NSWindow(contentViewController:)`, providing native `NSToolbar`
///   customization and `NSTabViewController` toolbar-tab integration.
///
/// Both paths share the same lifecycle (`Lifecycle/`): the async `launch`
/// overloads return right after the window is on screen so the caller's code
/// runs to completion, windows stay open after `main` returns, and the process
/// terminates once every window has been closed.
///
/// Use the shared singleton instance `WindowLauncher.shared` to access these methods.
public final class WindowLauncher: @unchecked Sendable {
    /// The shared singleton instance of `WindowLauncher`.
    public static let shared = WindowLauncher()

    /// Creates a new instance of `WindowLauncher`.
    public init() {}
}
