//
//  JSSelection.swift
//  WebReader
//
//  Created by Kai Shao on 2024/11/17.
//

import Foundation
import CryptoKit

public struct JSSelection: CoSendable, Hashable {
    public let string: String
    public let serializedRange: JSRange
    public let bounds: JSDOMRect
    public let id: String
    
    public init(string: String, range: JSRange, bounds: JSDOMRect) {
        self.string = string
        self.serializedRange = range
        self.bounds = bounds
        
        // Convert the properties into a single string
        let combinedString = string + (try! serializedRange.toString()) + (try! bounds.toString())
        
        // Compute the SHA256 hash for the combined string
        let digest = SHA256.hash(data: combinedString.data(using: .utf8)!)
        self.id = digest.compactMap { String(format: "%02x", $0) }.joined()
    }
}
