//
//  MainFuncExample.swift
//  SwiftWindowLauncher
//
//  Created by 茅根啓介 on 2025/08/22.
//

import WindowLauncher

@main
struct MainFuncExample {
    static func main() async throws {
        for second in 0..<5 {
            print("\(second) seconds")
            try await Task.sleep(for: .seconds(1))
        }
        
        WindowLauncher.shared.launchWindow {
            MainFuncView()
        }
    }
}
