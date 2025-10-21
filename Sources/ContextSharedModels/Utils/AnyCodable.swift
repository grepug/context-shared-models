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

    /// Initialize with any Codable type that may not be Hashable
    public init<T: Codable>(codable value: T) {
        // For Codable types, we'll encode them to JSON and store as Data
        // This ensures we can always decode them back properly
        do {
            let jsonData = try JSONEncoder().encode(value)
            if let jsonObject = try JSONSerialization.jsonObject(with: jsonData) as? AnyHashable {
                self.value = jsonObject
            } else {
                // Fallback: try to convert to AnyHashable if possible
                self.value = value as? AnyHashable
            }
        } catch {
            // Fallback: try to convert to AnyHashable if possible
            self.value = value as? AnyHashable
        }
    }

    public init<T: Codable>(codable value: T, encoder: JSONEncoder) throws {
        // For Codable types with custom encoder, use the provided encoder
        let jsonData = try encoder.encode(value)
        if let jsonObject = try JSONSerialization.jsonObject(with: jsonData) as? AnyHashable {
            self.value = jsonObject
        } else {
            // Fallback: try to convert to AnyHashable if possible
            self.value = value as? AnyHashable
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            self.value = nil
        } else if let intValue = try? container.decode(Int.self) {
            self.value = intValue
        } else if let stringValue = try? container.decode(String.self) {
            self.value = stringValue
        } else if let boolValue = try? container.decode(Bool.self) {
            self.value = boolValue
        } else if let doubleValue = try? container.decode(Double.self) {
            self.value = doubleValue
        } else if let floatValue = try? container.decode(Float.self) {
            self.value = floatValue
        } else if let arrayValue = try? container.decode([AnyCodable].self) {
            self.value = arrayValue.map { $0.value }
        } else if let dictionaryValue = try? container.decode([String: AnyCodable].self) {
            self.value = dictionaryValue.mapValues { $0.value }
        } else {
            // For any other type, try to decode as a dictionary representation
            // This handles custom Codable types generically
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
        } else if let floatValue = value as? Float {
            try container.encode(floatValue)
        } else if let arrayValue = value as? [AnyHashable] {
            // For arrays, we need to handle nested AnyCodable values properly
            let processedArray = arrayValue.map { element -> AnyCodable in
                if let anyCodableElement = element as? AnyCodable {
                    return anyCodableElement
                } else {
                    return AnyCodable(element)
                }
            }
            try container.encode(processedArray)
        } else if let dictionaryValue = value as? [String: AnyHashable] {
            // For dictionaries, we need to handle nested AnyCodable values properly
            var processedDict: [String: AnyCodable] = [:]
            for (key, dictValue) in dictionaryValue {
                if let anyCodableValue = dictValue as? AnyCodable {
                    processedDict[key] = anyCodableValue
                } else {
                    processedDict[key] = AnyCodable(dictValue)
                }
            }
            try container.encode(processedDict)
        } else {
            // For any other type, try to encode as a string representation
            // This is safer than trying complex JSON serialization
            let stringValue = String(describing: value!)
            try container.encode(stringValue)
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

    private func encodeCodableAsDict(_ value: AnyHashable) throws -> [String: AnyCodable]? {
        let actualValue = unwrapAnyHashableIfNeeded(value) ?? value
        let mirror = Mirror(reflecting: actualValue)

        // Check if this looks like a codable struct/class
        guard mirror.displayStyle == .struct || mirror.displayStyle == .class else {
            return nil
        }

        // Try to use reflection to extract properties
        var dict: [String: AnyCodable] = [:]

        for child in mirror.children {
            if let label = child.label {
                // Recursively handle nested values
                dict[label] = AnyCodable(child.value as? AnyHashable)
            }
        }

        return dict.isEmpty ? nil : dict
    }

    private func unwrapAnyHashableIfNeeded(_ value: AnyHashable?) -> AnyHashable? {
        guard let value = value else { return nil }

        // Use Mirror to check if AnyHashable is wrapping something we can extract
        let mirror = Mirror(reflecting: value)

        // Look for the base value inside AnyHashable
        if let baseChild = mirror.children.first(where: { $0.label == "_box" || $0.label == "base" }) {
            return baseChild.value as? AnyHashable ?? value
        }

        return value
    }

    public func decoding<T: Codable>(as type: T.Type, encoder: JSONEncoder = .init(), decoder: JSONDecoder = .init()) throws -> T {
        let data = try encoder.encode(self)
        return try decoder.decode(T.self, from: data)
    }

    /// Extract a specific Codable type from the stored value
    public func extracting<T: Codable>(_ type: T.Type) -> T? {
        // Direct cast if possible
        if let directValue = value as? T {
            return directValue
        }

        // Try to decode using JSON if the value exists
        do {
            return try decoding(as: type)
        } catch {
            // Try converting from JSON object back to the desired type only for valid JSON objects
            if let jsonObject = value,
                JSONSerialization.isValidJSONObject(jsonObject)
            {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: jsonObject)
                    return try JSONDecoder().decode(type, from: jsonData)
                } catch {
                    return nil
                }
            }
            return nil
        }
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
