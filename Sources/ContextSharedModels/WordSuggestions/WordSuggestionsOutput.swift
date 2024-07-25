//
//  WordSuggestionsOutput.swift
//  ContextSharedModels
//
//  Created by Kai on <insert date here>.
//

import Foundation

public struct WordSuggestionsOutput: CoSendable {
    public struct TokenItem: CoSendable {
        public let id: String
        public let token: String
        public let range: [Int]
        public let adjacentText: String
        public let pos: ContextModel.PartOfSpeech

        public init(id: String = UUID().uuidString, token: String, range: [Int], adjacentText: String, pos: ContextModel.PartOfSpeech) {
            self.id = id
            self.token = token
            self.range = range
            self.adjacentText = adjacentText
            self.pos = pos
        }
    }

    public let tokens: [TokenItem]?
    public let items: [String: WordSuggestionsOutputItem]?
    public let error: [String: String]?

    public init(tokens: [TokenItem]? = nil, items: [String: WordSuggestionsOutputItem]? = nil, error: [String: String]? = nil) {
        self.tokens = tokens
        self.items = items
        self.error = error
    }
}
