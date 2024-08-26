//
//  WordSuggestionsInput.swift
//
//
//  Created by Kai Shao on 2024/7/18.
//

public struct WordSuggestionInput: CoSendable {
    public let text: String

    public init(text: String) {
        self.text = text
    }
}

public struct TextRangeLookUpInput: CoSendable {
    public let text: String
    public let token: ContextModel.TokenItem

    public init(text: String, token: ContextModel.TokenItem) {
        self.text = text
        self.token = token
    }
}
