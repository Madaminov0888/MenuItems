//
//  KeyboardShortcuts+.swift
//  MenuItems
//
//  Created by Muhammadjon Madaminov on 20/01/25.
//

import Foundation
import KeyboardShortcuts


extension KeyboardShortcuts.Name {
    static let screencaptureFull = Self("screencaptureFull", default: .init(.three, modifiers: [.option, .command]))
    static let screencaptureArea = Self("screencaptureArea", default: .init(.four, modifiers: [.option, .command]))
    static let screencaptureWindow = Self("screencaptureWindow", default: .init(.five, modifiers: [.option, .command]))
}
