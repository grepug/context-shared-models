//
//  AnyCodable.swift
//  ContextApp
//
//  Created by Kai Shao on 2024/11/17.
//

import Foundation

public struct AnyCodable: Codable, Hashable, @unchecked Sendable {
    public let value: AnyHashable?

    public init<T: Codable & Hashable>(_ value: T) {
        self.value = value
    }

    public init(_ value: AnyHashable?) {
        self.value = value
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            value = nil
        } else if let intValue = try? container.decode(Int.self) {
            value = intValue
        } else if let stringValue = try? container.decode(String.self) {
            value = stringValue
        } else if let boolValue = try? container.decode(Bool.self) {
            value = boolValue
        } else if let doubleValue = try? container.decode(Double.self) {
            value = doubleValue
        } else if let arrayValue = try? container.decode([AnyCodable].self) {
            value = arrayValue.map { $0.value }
        } else if let dictionaryValue = try? container.decode([String: AnyCodable].self) {
            value = dictionaryValue.mapValues { $0.value }
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unsupported type")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        // Handle nil values more robustly
        if value == nil {
            try container.encodeNil()
        } else if isNilValue(value) {
            try container.encodeNil()
        } else if let intValue = value as? Int {
            try container.encode(intValue)
        } else if let stringValue = value as? String {
            try container.encode(stringValue)
        } else if let boolValue = value as? Bool {
            try container.encode(boolValue)
        } else if let doubleValue = value as? Double {
            try container.encode(doubleValue)
        } else if let arrayValue = value as? [AnyHashable] {
            let anyCodableArray = arrayValue.map { AnyCodable($0) }
            try container.encode(anyCodableArray)
        } else if let dictionaryValue = value as? [String: AnyHashable] {
            let anyCodableDictionary = dictionaryValue.mapValues { AnyCodable($0) }
            try container.encode(anyCodableDictionary)
        } else {
            // More detailed error information
            let valueDescription = String(describing: value)
            let valueType = type(of: value)
            throw EncodingError.invalidValue(
                valueDescription,
                EncodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unsupported type: \(valueType), value: \(valueDescription)"
                )
            )
        }
    }

    private func isNilValue(_ value: AnyHashable?) -> Bool {
        guard let value = value else { return true }

        // Check if the value is an Optional that contains nil
        let mirror = Mirror(reflecting: value)
        if mirror.displayStyle == .optional {
            return mirror.children.isEmpty
        }

        // Check if the AnyHashable itself contains a nil value by examining its base
        let anyHashableMirror = Mirror(reflecting: value)
        if let child = anyHashableMirror.children.first {
            let childMirror = Mirror(reflecting: child.value)
            if childMirror.displayStyle == .optional && childMirror.children.isEmpty {
                return true
            }
        }

        return false
    }

    public func decoding<T: Codable>(as type: T.Type, encoder: JSONEncoder = .init(), decoder: JSONDecoder = .init()) throws -> T {
        let data = try encoder.encode(self)
        return try decoder.decode(T.self, from: data)
    }

    public var params: [String: String] {
        if let dict = value as? [String: String] {
            return dict
        }

        var params = [String: String]()

        guard let value else {
            return params
        }

        let mirror = Mirror(reflecting: value)
        for child in mirror.children {
            if let key = child.label {
                params[key] = "\(child.value)"
            }
        }

        return params
    }
}
