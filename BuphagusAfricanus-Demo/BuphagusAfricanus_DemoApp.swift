//
//  BuphagusAfricanus_DemoApp.swift
//  BuphagusAfricanus-Demo
//
//  Created by Iris on 2025-02-19.
//

import SwiftUI
import BuphagusAfricanus

@main
struct BuphagusAfricanus_DemoApp: App {
    
    @NSApplicationDelegateAdaptor(baAppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
