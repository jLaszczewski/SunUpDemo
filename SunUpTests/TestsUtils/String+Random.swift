// Copyright © 2021 Inditex. All rights reserved.

import Foundation

extension String {
    static func random(length: Int = 20) -> String {
        random(characters: "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", length: length)
    }

    static func random(characters: String, length: Int = 20) -> String {
        var string = ""
        for _ in 0..<length {
            let randomIndex = Int(arc4random_uniform(UInt32(characters.count)))
            let advanced = characters.index(characters.startIndex, offsetBy: randomIndex)
            string += String(characters[advanced])
        }
        return string
    }
}
