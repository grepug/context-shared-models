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

public struct SingleWordLookUpInput: CoSendable {
    public let text: String
    public let range: [Int]

    public init(text: String, range: [Int]) {
        self.text = text
        self.range = range
    }
}
