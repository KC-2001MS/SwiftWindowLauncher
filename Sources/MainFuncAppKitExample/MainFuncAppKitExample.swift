//
//  MainFuncAppKitExample.swift
//  SwiftWindowLauncher
//
//  Created by 茅根啓介 on 2026/09/02.
//

import WindowLauncher

@main
struct MainFuncAppKitExample {
    @MainActor
    static func main() async throws {
        for second in 0..<5 {
            print("\(second) seconds")
            try await Task.sleep(for: .seconds(1))
        }
        
        await WindowLauncher.shared.launch(
            MainFuncAppKitViewController(),
            title: "Swift Window Launcher"
        )
        
        for second in 0..<3 {
            print("post-launch work \(second)")
            try await Task.sleep(for: .seconds(1))
        }
        print("main() finished — the window stays open until closed")
    }
}
