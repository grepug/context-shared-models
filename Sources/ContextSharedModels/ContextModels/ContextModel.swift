//
//  ContextModels.swift
//
//
//  Created by Kai Shao on 2024/5/27.
//

import Foundation

public protocol ContextModelKind: Codable, Hashable, Identifiable, CoSendable {
    static var typeName: String { get }

    var id: ContextModelID { get }
    var createdAt: Date { get }

    init()
}

public typealias ContextModelID = String

public enum ContextModel {}
