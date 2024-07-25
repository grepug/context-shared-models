//
//  WordSuggestionsOutputItem.swift
//
//
//  Created by Kai Shao on 2024/7/18.
//

import Foundation

public enum CTLocale: String, CodingKeyRepresentable, CoSendable {
    case en
    case zh_Hans = "zh-Hans"
    case zh_Hant = "zh-Hant"
    case ja, fr
}

public typealias LocaledStringDict = [CTLocale: String]

public struct WordSuggestionsOutputItem: Identifiable, Hashable, CoSendable {
    public var word: String
    public var pos: ContextModel.PartOfSpeech
    public var synonym: String?
    public var lemma: String
    public var sense: LocaledStringDict
    public var desc: LocaledStringDict

    public var id: String {
        word + pos.rawValue
    }

    public init(word: String = "", pos: ContextModel.PartOfSpeech = .verb, lemma: String = "", synonym: String? = nil, sense: LocaledStringDict = [:], desc: LocaledStringDict = [:]) {
        self.word = word
        self.pos = pos
        self.lemma = lemma
        self.synonym = synonym
        self.sense = sense
        self.desc = desc
    }

    public init(word: String, pos: ContextModel.PartOfSpeech = .verb, lemma: String, synonym: String?, sense: String, desc: String) {
        self.word = word
        self.pos = pos
        self.lemma = lemma
        self.synonym = synonym
        self.sense = [.en: sense]
        self.desc = [.en: desc]
    }
}
