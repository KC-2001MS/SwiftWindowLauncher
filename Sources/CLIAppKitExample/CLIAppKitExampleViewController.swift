//
//  CLIAppKitExampleViewController.swift
//  SwiftWindowLauncher
//
//  Created by 茅根啓介 on 2026/09/02.
//

import AppKit

/// A tab-based content controller. Because WindowLauncher hosts it in a plain
/// `NSWindow(contentViewController:)`, `tabStyle = .toolbar` integrates the
/// tabs into the window's toolbar.
final class CLIAppKitViewController: NSTabViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabStyle = .toolbar
        
        addTab(
            HomePaneViewController(),
            label: "Home",
            symbolName: "house"
        )
        addTab(
            InfoPaneViewController(),
            label: "Info",
            symbolName: "info.circle"
        )
    }
    
    private func addTab(
        _ viewController: NSViewController,
        label: String,
        symbolName: String
    ) {
        let item = NSTabViewItem(viewController: viewController)
        item.label = label
        item.image = NSImage(
            systemSymbolName: symbolName,
            accessibilityDescription: label
        )
        addTabViewItem(item)
    }
}

final class HomePaneViewController: NSViewController {
    override func loadView() {
        let label = NSTextField(labelWithString: "Hello, Swift Window Launcher!")
        label.font = .preferredFont(forTextStyle: .largeTitle)
        
        let closeButton = NSButton(
            title: "Close Window",
            target: self,
            action: #selector(closeWindow)
        )
        
        let stack = NSStackView(views: [label, closeButton])
        stack.orientation = .vertical
        stack.alignment = .centerX
        stack.spacing = 16
        stack.edgeInsets = NSEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
        
        view = stack
    }
    
    @objc private func closeWindow() {
        view.window?.close()
    }
}

final class InfoPaneViewController: NSViewController {
    override func loadView() {
        let label = NSTextField(
            labelWithString: "This window was launched by SwiftWindowLauncher."
        )
        
        let stack = NSStackView(views: [label])
        stack.edgeInsets = NSEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
        
        view = stack
    }
}
