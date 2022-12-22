//
//  CGColor+Extension.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 22.12.2022.
//

import CoreGraphics

extension CGColor {

    static func fromHexCode(_ code: String) -> CGColor {

        if (code.count == 7 && code.hasPrefix("#")) {
            let r = code.index(code.startIndex, offsetBy: 1)
            let g = code.index(code.startIndex, offsetBy: 3)
            let b = code.index(code.startIndex, offsetBy: 5)

            if let rHex = Int(code[r..<g], radix: 16),
                let gHex = Int(code[g..<b], radix: 16),
                let bHex = Int(code[b...], radix: 16) {

                return CGColor(red: CGFloat(rHex) / 0xff,
                               green: CGFloat(gHex) / 0xff,
                               blue: CGFloat(bHex) / 0xff,
                               alpha: 1.0)
            }
        }

        return CGColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.0)
    }

    static let red = CGColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    static let green = CGColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
    static let blue = CGColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)

    static let customColor = fromHexCode("#9C1E68")
    
}
