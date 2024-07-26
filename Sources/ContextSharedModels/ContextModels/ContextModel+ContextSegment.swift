//
//  ContextModel+ContextSegment.swift
//
//
//  Created by Kai Shao on 2024/6/16.
//

import Foundation

extension ContextModel {
    public struct ContextSegment: ContextModelKind, TokenKind {
        public static var typeName: String {
            "ContextSegment"
        }

        public var id: ContextModelID
        public var createdAt: Date
        public var contextID: ContextModelID?
        public var collectionID: ContextModelID?
        public var segment: Segment
        public var text: String
        public var lemma: String?
        public var pos: PartOfSpeech?
        public var synonym: String?
        public var tag: ContextModel.TokenTag?
        public var sense: LocaledStringDict
        public var desc: LocaledStringDict
        public var temporary: Bool

        // if the lemma is nil, then use the text as the lemma
        public var normalizedLemma: String {
            lemma ?? text
        }

        public var range: [Int] {
            switch segment {
            case .textRange(let segmentTextRange):
                return [segmentTextRange.lowerBound, segmentTextRange.upperBound]
            }
        }

        // optional has context item
        public var context: ContextModel.Context?

        public var textRange: CharacterRange? {
            switch segment {
            case .textRange(let segmentTextRange):
                return segmentTextRange
            }
        }

        public func subtextRange(from string: String) -> Range<String.Index>? {
            switch segment {
            case .textRange(let range):
                // Guard to ensure the range is within bounds
                guard range.lowerBound >= 0, range.upperBound <= string.count, range.lowerBound < range.upperBound else {
                    return nil
                }

                let start = string.index(string.startIndex, offsetBy: range.lowerBound)
                let end = string.index(string.startIndex, offsetBy: range.upperBound)
                return start..<end
            }
        }

        public func subtextRange(from aString: AttributedString) -> Range<AttributedString.Index>? {
            let string = NSAttributedString(aString).string

            switch segment {
            case .textRange(let range):
                // Guard to ensure the range is within bounds
                guard range.lowerBound >= 0, range.upperBound <= string.count, range.lowerBound < range.upperBound else {
                    return nil
                }

                let start = aString.index(aString.startIndex, offsetByCharacters: range.lowerBound)
                let end = aString.index(aString.startIndex, offsetByCharacters: range.upperBound)

                return start..<end
            }
        }

        public init(
            id: ContextModelID = Foundation.UUID().uuidString, createdAt: Date = .now, contextID: ContextModelID? = nil, segment: Segment = .textRange(.placeholder), text: String = "",
            lemma: String = "", pos: PartOfSpeech? = nil, synonym: String? = nil, sense: LocaledStringDict = [:], desc: LocaledStringDict = [:], phoneticSymbols: PhoniticSymbolDict = [:],
            context: Context? = nil, temporary: Bool = false
        ) {
            self.id = id
            self.createdAt = createdAt
            self.contextID = contextID
            self.segment = segment
            self.temporary = temporary
            self.text = text
            self.lemma = lemma
            self.pos = pos
            self.synonym = synonym
            self.sense = sense
            self.desc = desc
            self.context = context
        }

        public init?(
            id: ContextModelID, createdAt: Date = .now, contextID: ContextModelID? = nil, segmentString: String?, text: String = "", lemma: String = "", pos: PartOfSpeech? = nil,
            synonym: String? = nil,
            sense: LocaledStringDict = [:], desc: LocaledStringDict = [:], context: Context? = nil, temporary: Bool = false
        ) {
            guard let segmentString,
                let textSegment = CharacterRange(string: segmentString)
            else {
                return nil
            }

            self.id = id
            self.createdAt = createdAt
            self.contextID = contextID
            self.temporary = temporary
            self.segment = .textRange(textSegment)
            self.text = text
            self.lemma = lemma
            self.pos = pos
            self.synonym = synonym
            self.sense = sense
            self.desc = desc
            self.context = context
        }

        public init() {
            self.init(id: Foundation.UUID().uuidString)
        }
    }
}

extension ContextModel.ContextSegment {
    public enum Segment: Hashable, CoSendable {
        case textRange(CharacterRange)

        public var textRange: CharacterRange? {
            if case .textRange(let range) = self {
                return range
            }

            return nil
        }
    }
}
