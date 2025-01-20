//
//  SettingsView.swift
//  MenuItems
//
//  Created by Muhammadjon Madaminov on 20/01/25.
//

import SwiftUI
import KeyboardShortcuts
import AppKit

struct SettingsView: View {
    @AppStorage("showOnDock") var showOnDock: Bool = true
    
    var body: some View {
        TabView {
            Tab("Keyboard shortcuts", systemImage: "keyboard") {
                keyboardShortcutsSettings()
                    .frame(maxWidth: 500)
                    .padding()
            }
            Tab("Settings", systemImage: "gear") {
                Form {
                    Toggle(isOn: $showOnDock) {
                        Text("Keep icon on dock")
                    }
                    
                    Button("Quit application", role: .destructive) {
                        NSApp.terminate(nil)
                    }
                    .padding(.vertical)
                }
                .frame(height: 100)
                .frame(maxWidth: 500)
                .padding()
            }
        }
        .onChange(of: showOnDock) { oldValue, newValue in
            toggleAppVisibility(hideFromDock: !newValue)
        }
    }
}

#Preview {
    SettingsView()
}





extension SettingsView {
    @ViewBuilder private func keyboardShortcutsSettings() -> some View {
        Form {
            KeyboardShortcuts.Recorder("Screenshot full screen", name: .screencaptureFull)
            KeyboardShortcuts.Recorder("Screenshot selected area", name: .screencaptureArea)
            KeyboardShortcuts.Recorder("Screenshot selected window", name: .screencaptureWindow)
        }
    }
    
    func toggleAppVisibility(hideFromDock: Bool) {
        // Change the app's activation policy
        if hideFromDock {
            NSApp.setActivationPolicy(.accessory) // Hides from Dock, keeps MenuBar
        } else {
            NSApp.setActivationPolicy(.regular) // Shows in Dock
        }
    }
}

