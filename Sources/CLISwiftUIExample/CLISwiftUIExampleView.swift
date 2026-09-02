//
//  CLISwiftUIExampleView.swift
//  SwiftWindowLauncher
//
//  Created by 茅根啓介 on 2025/08/22.
//

import SwiftUI

struct CLISwiftUIView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                VStack {
                    Text("Hello, Swift Window Launcher!")
                        .font(.largeTitle)
                        .padding()
                    
                    Button("Close Window") {
                        dismiss()
                    }
                    .padding()
                }
            }
            
            Tab("Info", systemImage: "info.circle") {
                Text("This window was launched by SwiftWindowLauncher.")
                    .padding()
            }
        }
        .navigationTitle("Swift Window Launcher")
    }
}
