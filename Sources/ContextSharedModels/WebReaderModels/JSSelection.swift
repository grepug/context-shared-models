//
//  JSSelection.swift
//  WebReader
//
//  Created by Kai Shao on 2024/11/17.
//

import Foundation

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
        self.id = combinedString
    }
}
