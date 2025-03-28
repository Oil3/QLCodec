//
//  ContentView.swift
//  mkv Quicklook
//
//  Created by Almahdi Morris Quet on 02/18/25.

import SwiftUI
import QuickLookUIs
import UniformTypeIdentifiers

struct ContentView: View {
    let sampleFileURL = Bundle.main.url(forResource: "sample", withExtension: "mkv")!
    @State private var customFileURL: URL? = nil
    @State private var isShowingFilePicker = false
    public var buttonpressed = Bool()
    
    var body: some View {
        Text(" ")
        
      VStack(spacing: 20) {
            // Sample file button
            Button(action: { 
                QuickLookPanel(url: sampleFileURL).dfdfdefd() 
            }) {
    Image(nsImage: NSApplication.shared.applicationIconImage)
                    //.resizable()
                    //.frame(width: 32, height: 32)
            }
            .buttonStyle(.borderless)
            .keyboardShortcut(KeyEquivalent.space, modifiers: [])
            .help("Press space to view sample file or click the icon")
            
            // Custom file button
            Button(action: {
                isShowingFilePicker = true
            }) {
                Label("Open", systemImage: "folder")
            }
            .keyboardShortcut(KeyEquivalent("o"), modifiers: .command)
            .fileImporter(
                isPresented: $isShowingFilePicker,
                allowedContentTypes: [UTType.data], //[UTType.movie, UTType.audio, UTType.video, UTType.da],
                allowsMultipleSelection: false
            ) { result in
                switch result {
                case .success(let urls):
                    if let selectedURL = urls.first {
                        customFileURL = selectedURL
                        // Start QuickLook with the selected file
                        QuickLookPanel(url: selectedURL).dfdfdefd()
                    }
                case .failure(let error):
                    print("Error selecting file: \(error.localizedDescription)")
                }
            }
        }
        
        VStack {
            Text("QL Codec registered!")
                .font(.title2)
                          Text("Press space to check sample video, or Open to choose from Finder")
                .font(.title2)
        }
        .padding()
        VStack {
            Text("QL Codec makes “Quick Look“ play everything.")
                .monospaced()
            
            Text("Persistent settings are accessible all the time by right-clicking inside the Quick Look preview.")
                .monospaced()
                //.font(.footnote)
        }
        
        .frame(minWidth: 100, idealWidth: 200, minHeight: 50, idealHeight: 100)
        .onDisappear {
            NSApplication.shared.terminate(nil)
        }
.onDrop(of: ["public.file-url"], isTargeted: nil) { providers -> Bool in
    guard let provider = providers.first else { return false }
              provider.loadDataRepresentation(forTypeIdentifier: "public.file-url") { (data, error) in
        if let data = data,
           let path = NSString(data: data, encoding: 4), 
           let url = URL(string: path as String) {
            DispatchQueue.main.async {
                customFileURL = url
                QuickLookPanel(url: url).dfdfdefd()
            }
        }
    }
    return true
}

    }
}

//struct QuickLookPanel {
//    let url: URL
//    
//    func dfdfdefd() {
//        let panel = QLPreviewPanel.shared()
//        let controller = QuickLookController(url: url)
//        panel.dataSource = controller
//        panel.makeKeyAndOrderFront(nil)
//    }
//}

class QuickLookController: NSObject, QLPreviewPanelDataSource {
    let url: URL
    
    init(url: URL) {
        self.url = url
        super.init()
    }
    
    func numberOfPreviewItems(in panel: QLPreviewPanel!) -> Int {
        return 1
    }
    
    func previewPanel(_ panel: QLPreviewPanel!, previewItemAt index: Int) -> QLPreviewItem! {
        return url as QLPreviewItem
    }
}
