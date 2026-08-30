//
//  MainFuncExampleView.swift
//  SwiftWindowLauncher
//
//  Created by 茅根啓介 on 2025/08/22.
//

import SwiftUI

struct MainFuncView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello, SwiftGUILauncher!")
                    .font(.largeTitle)
                    .padding()
                
                Button("Close Window") {
                    dismiss()
                }
                .padding()
            }
            .navigationTitle("Test")
        }
    }
}

