//
//  JSRange.swift
//  WebReader
//
//  Created by Kai Shao on 2024/11/17.
//

import Foundation

public struct JSRange: CoSendable, Hashable {
    public let startContainer: String
    public let endContainer: String
    public let startOffset: Int
    public let endOffset: Int
}
