//
//  MenuItemsApp.swift
//  MenuItems
//
//  Created by Muhammadjon Madaminov on 19/01/25.
//

import SwiftUI

@main
struct MenuItemsApp: App {
    @StateObject private var vm: MainViewModel = MainViewModel()
    
    
    var body: some Scene {
        MenuBarExtra("MenuItems", systemImage: "photo.badge.plus.fill") {
            ContentView()
                .environmentObject(vm)
        }
        .defaultSize(width: 300, height: 300)
        .defaultLaunchBehavior(.presented)
        .menuBarExtraStyle(.window)
        
        
        Settings {
            SettingsView()
        }
    }
}
