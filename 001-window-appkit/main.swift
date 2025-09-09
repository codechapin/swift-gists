//
//  Simple AppKit Window without Storyboard
//

import Cocoa

let width = 800
let height = 600
let boxWidth = width / 2
let boxHeight = height / 2

class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ notification: Notification) {
       
        let contentRect = NSRect(x: 0, y: 0,
                                 width: width, height: height)
        
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
        window.backgroundColor = NSColor.systemGray
        window.center()

        // using the contentView without a Controller,
        // see below for an example with a Controller
        let view = window.contentView!

        //let controller = NSViewController()
        //window.contentViewController = controller
        //let view = controller.view

        let box = NSBox()
        box.boxType = .custom
        box.fillColor = NSColor.blue
        box.frame = NSRect(x: 0, y: 0, // from bottom left
            width: boxWidth, height: boxHeight)

        view.addSubview(box)
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
