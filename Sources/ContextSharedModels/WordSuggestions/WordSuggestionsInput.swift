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

public protocol PromptInput: CoSendable {}

extension PromptInput {
    public var params: [String: String] {
        var params = [String: String]()
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            if let key = child.label {
                params[key] = "\(child.value)"
            }
        }
        return params
    }
}
