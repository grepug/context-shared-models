//
//  WordSuggestionsOutput.swift
//  ContextSharedModels
//
//  Created by Kai on <insert date here>.
//

import Foundation

public struct WordSuggestionsOutput: CoSendable {
    public typealias TokenItem = ContextModel.TokenItem

    public let tokens: [TokenItem]?
    public let items: [String: ContextModel.ContextSegment]?
    public let error: [String: String]?
    public let suggestedTokenIds: [String]?

    public init(tokens: [TokenItem]? = nil, suggestedTokenIds: [String]? = nil, items: [String: ContextModel.ContextSegment]? = nil, error: [String: String]? = nil) {
        self.tokens = tokens
        self.suggestedTokenIds = suggestedTokenIds
        self.items = items
        self.error = error
    }
}
