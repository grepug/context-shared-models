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
    public let range: [Int]
    public let tokenText: String
    public let ajacentText: String

    init(text: String, range: [Int], tokenText: String, ajacentText: String) {
        self.text = text
        self.range = range
        self.tokenText = tokenText
        self.ajacentText = ajacentText
    }
}
