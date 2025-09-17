//
//  Shows how to draw raw pixels to a CGImage and then show the pixels on a Window.
//

import Cocoa

typealias Color = UInt32
typealias Pixel = UnsafeMutablePointer<Color>
typealias Canvas = UnsafeMutableBufferPointer<Color>

let width = 800
let height = 600
let imageWidth = width / 2
let imageHeight = height / 2

let rawData = Pixel.allocate(capacity: imageWidth * imageHeight) // heap allocation
defer {
    rawData.deallocate()
}

class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    // software rendering in a platform independent way (I hope)
    func fillRect(canvas: Canvas, width: Int, height: Int, color: Color) {
        for i in 0..<(width * height) {
            canvas[i] = color
       }
    }

    func drawImage() -> NSImage? {
        // ABGR (AABBGGRR). (Use: CGBitmapInfo.byteOrder32Big)
        // let color: Color = 0xFFFF0000 // blue

        // RGBA (RRGGBBAA). Use CGBitmapInfo.byteOrder32Little
        let color: Color = 0x0000FFFF // blue

        let bitsPerComponent = 8
        let bytesPerRow = 4 * imageWidth
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo: Color = CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue

        let canvas = Canvas(start: rawData, count: imageWidth * imageHeight)
        defer {
            canvas.deinitialize() // not sure if should do this here
        }

        fillRect(canvas: canvas, width: imageWidth, height: imageHeight, color: color)

        if let ctx = CGContext(
            data: canvas.baseAddress,
            width: imageWidth,
            height: imageHeight,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: bitmapInfo,
            releaseCallback: nil,
            releaseInfo: nil) {

             return NSImage(cgImage: ctx.makeImage()!, size: NSSize(width: imageWidth, height: imageHeight))
        } else {
            return nil
        }
    }

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

        let image = drawImage()
        let imageView = NSImageView(frame: NSRect(
                x: 0, y: 0,
                width: imageWidth,
                height: imageHeight
        ))
        imageView.image = image!

        let view = window.contentView!
        view.addSubview(imageView)
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
