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

        public init(id: String = UUID().uuidString, token: String, range: [Int], adjacentText: String) {
            self.id = id
            self.token = token
            self.range = range
            self.adjacentText = adjacentText
        }
    }

    public let tokens: [TokenItem]?
    public let items: [Int: WordSuggestionsOutputItem]?
    public let error: [Int: String]?

    public init(tokens: [TokenItem]? = nil, items: [Int: WordSuggestionsOutputItem]? = nil, error: [Int: String]? = nil) {
        precondition(tokens != nil || items != nil || error != nil, "At least one of tokens, items, or error must be non-nil")

        self.tokens = tokens
        self.items = items
        self.error = error
    }
}
