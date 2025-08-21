//
//  CLIExampleView.swift
//  SwiftWindowLauncher
//
//  Created by 茅根啓介 on 2025/08/22.
//

import SwiftUI

struct CLIView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello, Swift Window Launcher!")
                    .font(.largeTitle)
                    .padding()
                
                Button("Close Window") {
                    NSApplication.shared.keyWindow?.close()
                }
                .padding()
            }
            .navigationTitle("Swift Window Launcher")
        }
    }
}
