//
//  WordLookUp.swift
//
//
//  Created by Kai Shao on 2024/7/18.
//

public struct WordLookUpInContextInput: PromptInput {
    public let text: String
    public let word: String
    public let langs: String
    public let adja: String

    public init(text: String, word: String, langs: [CTLocale] = [.en, .zh_Hans], adja: String) {
        self.text = text
        self.word = word
        self.langs = langs.map { $0.rawValue }.joined(separator: ",")
        self.adja = adja
    }
}

public typealias WordLookUpInContextRequest = DifyPromptRequest<WordLookUpInContextInput>
