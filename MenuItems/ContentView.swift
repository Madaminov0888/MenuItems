//
//  ContentView.swift
//  MenuItems
//
//  Created by Muhammadjon Madaminov on 19/01/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            MainView()
        }
        .onAppear {
            NSApp.setActivationPolicy(.accessory)
        }
    }
}

#Preview {
    ContentView()
}
