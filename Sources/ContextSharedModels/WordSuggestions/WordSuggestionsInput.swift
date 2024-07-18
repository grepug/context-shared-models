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
