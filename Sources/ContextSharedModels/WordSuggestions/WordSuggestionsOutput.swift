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
    public let finished: String?
    public let suggestedTokenIds: [String]?
    public let existingTokenIds: [String]?

    public init(
        tokens: [TokenItem]? = nil, suggestedTokenIds: [String]? = nil, existingTokenIds: [String]? = nil, items: [String: ContextModel.ContextSegment]? = nil, finished: String? = nil,
        error: [String: String]? = nil
    ) {
        self.tokens = tokens
        self.suggestedTokenIds = suggestedTokenIds
        self.existingTokenIds = existingTokenIds
        self.items = items
        self.finished = finished
        self.error = error
    }
}
