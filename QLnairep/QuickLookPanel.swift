//
//  QuickLookPreview.swift
//  Webm Quicklook
//
//  Created by ZZS on 18/02/2024.
//
import SwiftUI
import Quartz

struct QuickLookPanel: NSViewRepresentable {
    var url: URL
    
    func makeNSView(context: Context) -> NSView {
        let view = NSView()
      view.frame.size.width = 640
      view.frame.size.height = 448
        DispatchQueue.main.async {
            context.coordinator.showPanel()
        }
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        context.coordinator.url = url
    }
    
    func makeCoordinator() -> Coordinator {
       
        Coordinator(url: url)
    }
    
      func dfdfdefd() {
      Coordinator(url: url).showPanel()
      
    }
    
    
class Coordinator: NSObject, QLPreviewPanelDataSource {
    var url: URL
    private var panel: QLPreviewPanel?
    
    init(url: URL) {
        self.url = url
    }
    
    func showPanel() {
        guard let panel = QLPreviewPanel.shared() else { return }
        self.panel = panel
        panel.dataSource = self
        
        // Observe window close notifications
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(windowWillClose(_:)),
            name: NSWindow.willCloseNotification,
            object: panel
        )
        
        panel.makeKeyAndOrderFront(nil)
    }
    
    @objc func windowWillClose(_ notification: Notification) {
        // Terminate app only when our panel closes
       // NSApplication.shared.terminate(nil)
    }
        
        // QLPreviewPanelDataSource
        func numberOfPreviewItems(in panel: QLPreviewPanel!) -> Int { 1 }
        
        func previewPanel(_ panel: QLPreviewPanel!, previewItemAt index: Int) -> QLPreviewItem! {
            url as QLPreviewItem
        }
        
 deinit {
        if let panel = panel {
            NotificationCenter.default.removeObserver(
                self, 
                name: NSWindow.willCloseNotification, 
                object: panel
            )
        }
    }
}
}
