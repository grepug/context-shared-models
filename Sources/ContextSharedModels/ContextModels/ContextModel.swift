//
//  ContextModels.swift
//
//
//  Created by Kai Shao on 2024/5/27.
//

import Foundation

public protocol ContextModelKind: Hashable, Identifiable, CoSendable {
    static var typeName: String { get }

    var id: ContextModel.ID { get }
    var createdAt: Date { get }

    init()
}

public enum ContextModel {
    public typealias ID = String
}

extension ContextModel {
    public enum TokenTag: CoSendable, Hashable {
        case person, organization, place
    }

    public protocol TokenKind: CoSendable, Hashable {
        var text: String { get set }
        var range: [Int] { get set }
        var tag: TokenTag? { get set }
        var pos: ContextModel.PartOfSpeech? { get set }
        var lemma: String? { get set }
    }
}

extension ContextModel.TokenKind {
    public mutating func from<T: ContextModel.TokenKind>(_ item: T) {
        text = item.text
        range = item.range
        tag = item.tag
        pos = item.pos
        lemma = item.lemma
    }
}

extension ContextModel {
    public enum PartOfSpeech: String, CoSendable, CaseIterable {
        case noun
        case verb
        case adjective
        case adverb
        case idiom
        case pv
    }

    public struct TokenItem: TokenKind {
        public let id: String
        public var text: String
        public var range: [Int]
        public let adjacentText: String
        public var pos: ContextModel.PartOfSpeech?
        public var lemma: String?
        public var tag: TokenTag?

        public init(id: String = UUID().uuidString, text: String, range: [Int], adjacentText: String, pos: ContextModel.PartOfSpeech? = nil, lemma: String? = nil) {
            self.id = id
            self.text = text
            self.range = range
            self.adjacentText = adjacentText
            self.pos = pos
            self.lemma = lemma
        }
    }
}
