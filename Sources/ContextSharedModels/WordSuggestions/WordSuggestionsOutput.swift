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
    public let items: [UUID: ContextModel.ContextSegment]?
    public let error: [UUID: String]?
    public let finished: UUID?
    public let suggestedTokenIds: [UUID]?
    public let existingTokenIds: [UUID]?

    public init(
        tokens: [TokenItem]? = nil, suggestedTokenIds: [UUID]? = nil, existingTokenIds: [UUID]? = nil, items: [UUID: ContextModel.ContextSegment]? = nil, finished: UUID? = nil,
        error: [UUID: String]? = nil
    ) {
        self.tokens = tokens
        self.suggestedTokenIds = suggestedTokenIds
        self.existingTokenIds = existingTokenIds
        self.items = items
        self.finished = finished
        self.error = error
    }
}

extension UUID: @retroactive CodingKeyRepresentable {
    public var codingKey: any CodingKey {
        return DynamicCodingKey(stringValue: self.uuidString)!
    }
    
    public init?<T>(codingKey: T) where T: CodingKey {
        guard let uuid = UUID(uuidString: codingKey.stringValue) else {
            return nil
        }
        self = uuid
    }
}

/// A helper `CodingKey` implementation for dynamic keys
public struct DynamicCodingKey: CodingKey {
    public var stringValue: String
    public var intValue: Int? { nil }
    
    public init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    public init?(intValue: Int) {
        return nil
    }
}
