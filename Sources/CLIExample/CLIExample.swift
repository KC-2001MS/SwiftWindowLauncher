//
//  Example.swift
//  SwiftGUILauncher
//
//  Created by 茅根啓介 on 2025/08/21.
//

import ArgumentParser
import WindowLauncher

@main
struct CLIExample: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "example",
        abstract: "A simple example of using SwiftGUILauncher.",
        subcommands: []
    )

    func run() async throws {
        for second in 0..<5 {
            print("\(second) seconds")
            try await Task.sleep(for: .seconds(1))
        }
        
        let launcher = WindowLauncher.shared
        launcher.launchWindow(view: CLIView())
    }

}
