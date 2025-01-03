//
//  JSSelection.swift
//  WebReader
//
//  Created by Kai Shao on 2024/11/17.
//

import Foundation

public struct JSSelection: CoSendable, Hashable {
    public let id: UUID
    public let string: String
    public let rangeItem: JSRange?
    public let offset: Int?
    
    public init(id: UUID, string: String, range: JSRange? = nil, offset: Int? = nil) {
        self.id = id
        self.string = string
        self.rangeItem = range
        self.offset = offset
    }
}
