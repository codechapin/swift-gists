//
//  Simple AppKit Window without Storyboard
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ notification: Notification) {
       
        let contentRect = NSRect(x: 0, y: 0,
                                 width: 800, height: 600)
        
        let styleMask: NSWindow.StyleMask = [
            .titled, .closable, .miniaturizable, .resizable
        ]
        
        window = NSWindow(contentRect: contentRect,
                          styleMask: styleMask,
                          backing: .buffered,
                          defer: false)
        
        window.title = "An AppKit Window"
        window.makeKeyAndOrderFront(nil)
        window.orderFrontRegardless()
        window.backgroundColor = NSColor.systemBlue
        window.center()

        // using the contentView without a Controller,
        // see below for an example with a Controller
        let view = window.contentView!

        //let controller = NSViewController()
        //window.contentViewController = controller
        //let view = controller.view

        view.wantsLayer = true

        let textWidth = 200.0
        let textHeight = 40.0

        let viewBounds = view.bounds
        let posX = (viewBounds.width - textWidth) / 2
        let posY = (viewBounds.height - textHeight) / 2

        let label = NSTextField(labelWithString: "Hello from NSWindow!")
        label.frame = NSRect(x: posX, y: posY, width: textWidth, height: textHeight)

        view.addSubview(label)
    }

    func applicationWillTerminate(_ notification: Notification) {
        // Clean up resources here
    }

    // Allow the application to quit when the main window is closed
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
