//
//  QLnairepApp.swift
//  QLnairep
//
//  Created by Almahdi Morris Quet on 03/26/25.
//

import SwiftUI

@main
struct QLnairepApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
  
}

class AppDelegate: NSObject, NSApplicationDelegate {
    
    func application(_ application: NSApplication, open urls: [URL]) {
        if let url = urls.first {
            DispatchQueue.main.async {
                let panel = QuickLookPanel(url: url)
                panel.dfdfdefd()
            }
        }
    }
    
    func application(_ sender: NSApplication, openFile filename: String) -> Bool {
        let url = URL(fileURLWithPath: filename)
        DispatchQueue.main.async {
            let panel = QuickLookPanel(url: url)
            panel.dfdfdefd()
        }
        return true
    }
}
