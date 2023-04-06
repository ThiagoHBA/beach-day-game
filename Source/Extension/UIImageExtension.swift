import Foundation
import UIKit

typealias RGB = (UInt8, UInt8, UInt8)

extension UIImage {

    func pixelLocations(from rgb: RGB) ->  Set<Location> {

        guard
            let cgImage = cgImage,
            let data = cgImage.dataProvider?.data,
            let bytes = CFDataGetBytePtr(data)
        else { return [] }

        var pixelLocations = [Location]()
        let bytesPerPixel = cgImage.bitsPerPixel / cgImage.bitsPerComponent

        for y in 0 ..< cgImage.height {
            for x in 0 ..< cgImage.width {
                let offset = (y * cgImage.bytesPerRow) + (x * bytesPerPixel)
                let components = (r: bytes[offset], g: bytes[offset + 1], b: bytes[offset + 2])
                if components == rgb {
                    pixelLocations.append(Location(CGPoint(x: x, y: y)))
                }
            }
        }

        let set = Set(pixelLocations)
        
        return set

    }
}
