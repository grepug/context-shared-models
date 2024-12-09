//
//  JSRange.swift
//  WebReader
//
//  Created by Kai Shao on 2024/11/17.
//

import Foundation

public struct JSRange: CoSendable, Hashable {
    public struct Bound: CoSendable, Hashable {
        public let containerXPath: String?
        public let offset: Int
    }

    public let startBound: Bound
    public let endBound: Bound
}
