//
//  ContextModels.swift
//
//
//  Created by Kai Shao on 2024/5/27.
//

import Foundation

public protocol ContextModelKind: Hashable, Identifiable, CoSendable {
    static var typeName: String { get }

    var id: ContextModelID { get }
    var createdAt: Date { get }

    init()
}

public typealias ContextModelID = String

public enum ContextModel {}

extension ContextModel {
    public enum PartOfSpeech: String, CoSendable, CaseIterable {
        case noun
        case verb
        case adjective
        case adverb
        case idiom
        case pv
    }
}
