//
//  CharacterRange.swift
//
//
//  Created by Kai Shao on 2024/7/10.
//

import Foundation

public struct CharacterRange: Hashable, CoSendable {
    public let lowerBound: Int
    public let upperBound: Int

    public var length: Int {
        upperBound - lowerBound
    }

    public init(lowerBound: Int, upperBound: Int) {
        precondition(lowerBound <= upperBound)

        self.lowerBound = lowerBound
        self.upperBound = upperBound
    }

    public init(array: [Int]) {
        precondition(array.count == 2)
        precondition(array[0] <= array[1])

        lowerBound = array[0]
        upperBound = array[1]
    }

    public init?(string: String) {
        let components = string.components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }

        guard let lowerString = components.element(at: 0),
            let upperString = components.element(at: 1),
            let lower = Int(lowerString),
            let upper = Int(upperString),
            lower < upper
        else {
            return nil
        }

        lowerBound = lower
        upperBound = upper
    }
}

extension CharacterRange {
    public var stringRepresentation: String {
        "\(lowerBound),\(upperBound)"
    }

    public static var placeholder: Self {
        .init(lowerBound: 0, upperBound: 1)
    }

    public mutating func move(locationOffset offset: Int) {
        self = CharacterRange(lowerBound: lowerBound + offset, upperBound: upperBound + offset)
    }

    public func contains(_ index: Int) -> Bool {
        index >= lowerBound && index <= upperBound
    }
}

public typealias SRange = Range<String.Index>
public typealias ARange = Range<AttributedString.Index>

extension CharacterRange {
    public func substring(in string: String) -> String {
        let sRange = sRange(in: string)
        return String(string[sRange])
    }

    public func sRange(in string: String) -> SRange {
        let startIndex = string.startIndex

        let start = string.index(startIndex, offsetBy: lowerBound)
        let end = string.index(startIndex, offsetBy: upperBound)

        precondition(start <= end)

        return start..<end
    }

    public func sRangeOptional(in string: String) -> SRange? {
        let startIndex = string.startIndex

        let start = string.index(startIndex, offsetBy: lowerBound, limitedBy: string.endIndex)
        let end = string.index(startIndex, offsetBy: upperBound, limitedBy: string.endIndex)

        guard let s = start, let e = end else {
            return nil
        }

        guard s <= e else {
            return nil
        }

        return s..<e
    }

    public func nsRange(in string: String) -> NSRange {
        let stringRange = sRange(in: string)
        return NSRange(stringRange, in: string)
    }
    
    public func nsRangeOptional(in string: String) -> NSRange? {
        guard let range = sRangeOptional(in: string) else {
            return nil
        }
        return NSRange(range, in: string)
    }

    public func aRange(in string: AttributedString) -> ARange {
        let startIndex = string.startIndex
        let start = string.index(startIndex, offsetByCharacters: lowerBound)
        let end = string.index(startIndex, offsetByCharacters: min(upperBound, string.string.count))

        precondition(start <= end)

        return start..<end
    }

    public func aRangeOptional(in string: AttributedString) -> ARange? {
        let startIndex = string.startIndex
        let start = string.index(startIndex, offsetByCharacters: lowerBound)
        let end = string.index(startIndex, offsetByCharacters: min(upperBound, string.string.count))

        guard start <= end else {
            return nil
        }

        return start..<end
    }
}

extension SRange {
    public func cRange(in string: String) -> CharacterRange {
        let start = string.distance(from: string.startIndex, to: lowerBound)
        let end = string.distance(from: string.startIndex, to: upperBound)
        return .init(lowerBound: start, upperBound: end)
    }

    public func cRange(in attributedString: AttributedString) -> CharacterRange {
        cRange(in: attributedString.string)
    }

    public func attributedStringRange(in string: String) -> ARange {
        let start = string.distance(from: string.startIndex, to: lowerBound)
        let end = string.distance(from: string.startIndex, to: upperBound)
        let attributedString = AttributedString(string)

        let lower = attributedString.index(attributedString.startIndex, offsetByCharacters: start)
        let upper = attributedString.index(attributedString.startIndex, offsetByCharacters: end)

        return lower..<upper
    }
}

extension NSRange {
    public func cRange(in string: String) -> CharacterRange {
        let sRange = Range(self, in: string)!
        return sRange.cRange(in: string)
    }
}

extension AttributedString {
    public var string: String {
        String(characters)
    }
}
