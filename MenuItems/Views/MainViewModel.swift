//
//  MainViewModel.swift
//  MenuItems
//
//  Created by Muhammadjon Madaminov on 19/01/25.
//

import Foundation
import SwiftUI
import KeyboardShortcuts



final class MainViewModel: ObservableObject {
    @Published var images: [NSImage] = [] {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                // Ensure updates are throttled
                self.objectWillChange.send()
            }
        }
    }
    
    
    init() {
        KeyboardShortcuts.onKeyUp(for: .screencaptureArea) { [self] in
            takeScreenShot(type: .area)
        }
        KeyboardShortcuts.onKeyUp(for: .screencaptureFull) { [self] in
            takeScreenShot(type: .full)
        }
        KeyboardShortcuts.onKeyUp(for: .screencaptureWindow) { [self] in
            takeScreenShot(type: .window)
        }
    }
    
    func takeScreenShot(type: ScreenshotTypes) {
        // Save the current clipboard content to compare later
        let previousClipboardData = NSPasteboard.general.data(forType: .tiff)

        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/sbin/screencapture")
        process.arguments = type.argument

        do {
            try process.run()
            process.waitUntilExit()
            
            // Check if clipboard was updated
            if isClipboardUpdated(previousData: previousClipboardData) {
                self.getImageFromClipboard()
            }
        } catch {
            print("Error running screencapture: \(error)")
        }
    }

    private func isClipboardUpdated(previousData: Data?) -> Bool {
        let currentClipboardData = NSPasteboard.general.data(forType: .tiff)
        return currentClipboardData != previousData
    }
    
    func getImageFromClipboard() {
        guard NSPasteboard.general.canReadItem(withDataConformingToTypes: NSImage.imageTypes) else { return }
        guard let image = NSImage(pasteboard: NSPasteboard.general) else { return }
        self.images.append(image)
    }
    
    
    
    enum ScreenshotTypes {
        case window
        case full
        case area
        
        
        var argument: [String] {
            switch self {
            case .window:
                ["-cw"]
            case .full:
                ["-c"]
            case .area:
                ["-cs"]
            }
        }
    }
}


