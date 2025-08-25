// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import AppKit

/// A utility class for launching new windows containing SwiftUI views or AppKit views.
/// 
/// This class provides methods to create and display new `NSWindow` instances with
/// specified content. It manages the application activation policy and ensures windows
/// are properly sized and configured.
/// 
/// Use the shared singleton instance `WindowLauncher.shared` to access these methods.
public final class WindowLauncher: @unchecked Sendable {
    /// The shared singleton instance of `WindowLauncher`.
    public static let shared = WindowLauncher()

    /// Creates a new instance of `WindowLauncher`.
    public init() {}

    /// Launches a new window containing the given SwiftUI view.
    ///
    /// - Parameter view: A closure returning the SwiftUI `View` to display in the new window.
    /// 
    /// This method must be called on the main actor as it interacts with AppKit UI components.
    /// It creates an `NSHostingView` from the provided SwiftUI view and delegates the window
    /// creation and display logic to `launchWindow(_ nsview: NSView)`.
    ///
    /// - Note: The application main run loop is started by the delegated method.
    @MainActor
    public func launchWindow<Content: View>(
        _ view: @Sendable @escaping () -> Content
    ) {
        let hostingView = NSHostingView(
            rootView: view().frame(maxWidth: .infinity, maxHeight: .infinity)
        )

        self.launchWindow(hostingView)
    }
    
    /// Launches a new window containing the given SwiftUI view.
    ///
    /// - Parameter view: An autoclosure returning the SwiftUI `View` to display in the new window.
    /// 
    /// This method must be called on the main actor as it interacts with AppKit UI components.
    /// It creates an `NSHostingView` from the provided SwiftUI view and delegates the window
    /// creation and display logic to `launchWindow(_ nsview: NSView)`.
    ///
    /// - Note: The application main run loop is started by the delegated method.
    @MainActor
    public func launchWindow<Content: View>(
        _ view: @Sendable @autoclosure @escaping () -> Content
    ) {
        let hostingView = NSHostingView(
            rootView: view().frame(maxWidth: .infinity, maxHeight: .infinity)
        )

        self.launchWindow(hostingView)
    }
    
    /// Launches a new window containing the specified AppKit `NSView`.
    ///
    /// - Parameter nsview: The `NSView` instance to be displayed in the new window.
    ///
    /// This method must be called on the main actor as it interacts with AppKit UI components.
    /// It creates the window with titled, closable, and resizable style masks, sets up
    /// constraints so that the content fills the window, sets minimum and maximum sizes,
    /// centers the window, makes it key and visible, activates the application, and starts
    /// the main application run loop.
    ///
    /// All window creation and management logic is centralized here.
    ///
    /// - Note: The application main run loop is started by this method.
    @MainActor
    public func launchWindow(
        _ nsview: NSView
    ) {
        print("Launching Window...")
        //        Task { @MainActor in
        let app = NSApplication.shared
        app.setActivationPolicy(.regular)
        
        let fittingSize = nsview.fittingSize
        
        nsview.translatesAutoresizingMaskIntoConstraints = false
        
        let newWindow = NSWindow(
            contentRect: NSRect(
                x: 0,
                y: 0,
                width: fittingSize.width,
                height: fittingSize.height
            ),
            styleMask: [.titled, .closable, .resizable],
            backing: .buffered,
            defer: false
        )
        newWindow.contentView = nsview
        
        
        // Auto Layout constraints
        if let contentView = newWindow.contentView {
            NSLayoutConstraint.activate([
                nsview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                nsview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                nsview.topAnchor.constraint(equalTo: contentView.topAnchor),
                nsview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }

        newWindow.minSize = NSSize(width: 200, height: 200)
        newWindow.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude,
                                   height: CGFloat.greatestFiniteMagnitude)
        newWindow.center()
        newWindow.makeKeyAndOrderFront(true)
        NSApp.activate(ignoringOtherApps: true)

        app.run()
        //        }
        //        
        //        RunLoop.main.run()
    }
}

