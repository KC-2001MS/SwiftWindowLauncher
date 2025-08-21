//
//  MainFuncExampleView.swift
//  SwiftWindowLauncher
//
//  Created by 茅根啓介 on 2025/08/22.
//

import SwiftUI

struct MainFuncView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello, SwiftGUILauncher!")
                    .font(.largeTitle)
                    .padding()
                Button("Close Window") {
                    NSApplication.shared.keyWindow?.close()
                }
                .padding()
            }
            .navigationTitle("Test")
        }
    }
}

