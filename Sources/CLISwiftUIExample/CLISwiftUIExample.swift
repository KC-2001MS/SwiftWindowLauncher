//
//  CLISwiftUIExample.swift
//  SwiftWindowLauncher
//
//  Created by 茅根啓介 on 2025/08/21.
//

import ArgumentParser
import WindowLauncher

@main
struct CLISwiftUIExample: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "cli-swiftui-example",
        abstract: "An example of launching a SwiftUI window from an ArgumentParser command.",
        subcommands: []
    )

    @MainActor
    func run() async throws {
        for second in 0..<5 {
            print("\(second) seconds")
            try await Task.sleep(for: .seconds(1))
        }
        
        let launcher = WindowLauncher.shared
        await launcher.launch(CLISwiftUIView())
        
        for second in 0..<3 {
            print("post-launch work \(second)")
            try await Task.sleep(for: .seconds(1))
        }
        print("run() finished — the window stays open until closed")
    }

}
