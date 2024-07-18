//
//  WordLookUp.swift
//
//
//  Created by Kai Shao on 2024/7/18.
//

public struct WordLookUpInContextInput: CoSendable {
    public let text: String
    public let word: String
    public let langs: String
    public let adja: String

    public init(text: String, word: String, langs: String, adja: String) {
        self.text = text
        self.word = word
        self.langs = langs
        self.adja = adja
    }
}

public typealias WordLookUpInContextRequest = DifyPromptRequest<WordLookUpInContextInput>
