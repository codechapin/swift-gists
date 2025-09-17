//
//  Shows how to draw raw pixels to a PPM image in the file system.
//

import Foundation

let channels = 3
let width = 512
let height = 512

let filePath = "blue.ppm"
let header = "P6\n\(width) \(height) 255\n"
let headerBytes: [UInt8] = Array(header.utf8)

let pixels = width * height
let bufferSize = headerBytes.count + (pixels * channels)

var byteArray = [UInt8](repeating: 0, count: bufferSize) // heap allocated, dynamic array
// this increases capacity
// byteArray.append(contentsOf: headerBytes).
// So we loop instead.
for i in 0..<headerBytes.count {
    byteArray[i] = headerBytes[i]
}

// ABGR (AABBGGRR)
let color: UInt32 = 0xFFFF0000 // blue

let redChannel  = UInt8((color >> (8*0)) & 0xFF)
let greenChannel = UInt8((color >> (8*1)) & 0xFF)
let blueChannel   = UInt8((color >> (8*2)) & 0xFF)

for i in stride(from: headerBytes.count, to: bufferSize, by: channels) {
    byteArray[i+0] = redChannel
    byteArray[i+1] = greenChannel
    byteArray[i+2] = blueChannel
}

let data = Data(bytes: byteArray, count: bufferSize)

let fileManager = FileManager.default

if fileManager.fileExists(atPath: filePath) {
    try fileManager.removeItem(atPath: filePath)
}

let success = fileManager.createFile(atPath: filePath, contents: data, attributes: nil)
if success {
    print("File created successfully at: \(filePath)")
} else {
    print("Failed to create file at: \(filePath)")
}
