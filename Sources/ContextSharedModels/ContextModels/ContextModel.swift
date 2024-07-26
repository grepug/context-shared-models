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
        var text: String { get }
        var range: [Int] { get }
        var tag: TokenTag? { get }
        var pos: ContextModel.PartOfSpeech? { get }
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
        public let text: String
        public let range: [Int]
        public let adjacentText: String
        public let pos: ContextModel.PartOfSpeech?
        public let lemma: String?
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
