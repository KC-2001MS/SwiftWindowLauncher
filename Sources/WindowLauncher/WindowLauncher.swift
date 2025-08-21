// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import AppKit

public final class WindowLauncher: @unchecked Sendable {
    public static let shared = WindowLauncher()

    private var window: NSWindow? = nil
    
    
    public init() {}

    public func launchWindow<Content: View>(
        _ view: @Sendable @escaping () -> Content
    ) {
        print("Launching Window...")
        Task { @MainActor in
            let app = NSApplication.shared
            app.setActivationPolicy(.regular)
            
            let hostingView = NSHostingView(rootView: view().frame(maxWidth: .infinity, maxHeight: .infinity))
            hostingView.translatesAutoresizingMaskIntoConstraints = false

            let fittingSize = hostingView.fittingSize
            
            let newWindow = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: fittingSize.width, height: fittingSize.height),
                styleMask: [.titled, .closable,.miniaturizable , .resizable],
                backing: .buffered,
                defer: false
            )
            
            newWindow.contentView = hostingView

            // Auto Layout 制約を追加
            if let contentView = newWindow.contentView {
                NSLayoutConstraint.activate([
                    hostingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    hostingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                    hostingView.topAnchor.constraint(equalTo: contentView.topAnchor),
                    hostingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
                ])
            }
            
            newWindow.center()
            newWindow.makeKeyAndOrderFront(true)
            NSApp.activate(ignoringOtherApps: true)
            
            newWindow.minSize = NSSize(width: 200, height: 200) // 最小サイズだけ決める
            newWindow.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude,
                                       height: CGFloat.greatestFiniteMagnitude)
            self.window = newWindow
                app.run()
        }
        
        RunLoop.main.run()
    }
    
    public func launchWindow<Content: View>(
        view: @Sendable @autoclosure @escaping () -> Content
    ) {
        print("Launching Window...")
        Task { @MainActor in
            let app = NSApplication.shared
            app.setActivationPolicy(.regular)
            
            let hostingView = NSHostingView(rootView: view().frame(maxWidth: .infinity, maxHeight: .infinity))
            hostingView.translatesAutoresizingMaskIntoConstraints = false
            
            let fittingSize = hostingView.fittingSize
            
            let newWindow = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: fittingSize.width, height: fittingSize.height),
                styleMask: [.titled, .closable,.miniaturizable , .resizable],
                backing: .buffered,
                defer: false
            )
            newWindow.contentView = hostingView

            // Auto Layout 制約を追加
            if let contentView = newWindow.contentView {
                NSLayoutConstraint.activate([
                    hostingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    hostingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                    hostingView.topAnchor.constraint(equalTo: contentView.topAnchor),
                    hostingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
                ])
            }
            
            newWindow.center()
            newWindow.makeKeyAndOrderFront(true)
            NSApp.activate(ignoringOtherApps: true)
            newWindow.minSize = NSSize(width: 200, height: 200) // 最小サイズだけ決める
            newWindow.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude,
                                       height: CGFloat.greatestFiniteMagnitude)
            
            self.window = newWindow
                app.run()
        }
        
        RunLoop.main.run()
    }
    
    public func launchWindow(
        _ nsview: NSView
    ) {
        print("Launching Window...")
        Task { @MainActor in
            let app = NSApplication.shared
            app.setActivationPolicy(.regular)
            let newWindow = NSWindow(
                contentRect: nsview.frame,
                styleMask: [.titled, .closable, .resizable],
                backing: .buffered,
                defer: false
            )
            newWindow.contentView = nsview
            newWindow.makeKeyAndOrderFront(true)
            NSApp.activate(ignoringOtherApps: true)
            
            self.window = newWindow
            app.run()
        }
        
        RunLoop.main.run()
    }
}
