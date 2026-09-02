//
//  MainFuncSwiftUIExample.swift
//  SwiftWindowLauncher
//
//  Created by 茅根啓介 on 2025/08/22.
//

import WindowLauncher

@main
struct MainFuncSwiftUIExample {
    static func main() async throws {
        for second in 0..<5 {
            print("\(second) seconds")
            try await Task.sleep(for: .seconds(1))
        }
        
        await WindowLauncher.shared.launch {
            MainFuncSwiftUIView()
        }
        
        for second in 0..<3 {
            print("post-launch work \(second)")
            try await Task.sleep(for: .seconds(1))
        }
        print("main() finished — the window stays open until closed")
    }
}
