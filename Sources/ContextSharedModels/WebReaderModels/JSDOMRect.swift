//
//  JSDOMRect.swift
//  WebReader
//
//  Created by Kai Shao on 2024/11/17.
//

import Foundation

public struct JSDOMRect: CoSendable, Hashable {
    public let x: CGFloat
    public let y: CGFloat
    public let width: CGFloat
    public let height: CGFloat
    public let top: CGFloat
    public let bottom: CGFloat
    public let left: CGFloat
    public let right: CGFloat
    
    var isZero: Bool {
        x == 0 && y == 0 && width == 0 && height == 0
    }
}
