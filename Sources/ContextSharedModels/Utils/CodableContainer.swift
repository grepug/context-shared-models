//
//  CodableContainer.swift
//  ContextApp
//
//  Created by Kai Shao on 2024/11/17.
//

import Foundation

/// A lightweight container for storing and transmitting arbitrary `Codable` types as JSON strings.
///
/// `CodableContainer` provides a simple, type-safe way to wrap any `Codable` value and encode it
/// as a JSON string. This is particularly useful when you need to:
/// - Store heterogeneous `Codable` types in a homogeneous collection
/// - Pass `Codable` values through APIs that don't support generic types
/// - Serialize `Codable` values for storage or transmission without losing type information
///
/// ## Usage
///
/// ### Basic Example
/// ```swift
/// struct User: Codable {
///     let id: Int
///     let name: String
/// }
///
/// let user = User(id: 1, name: "Alice")
///
/// // Encode
/// let container = try CodableContainer(user)
///
/// // Decode
/// let decoded = try container.decoding(as: User.self)
/// ```
///
/// ### Working with Collections
/// ```swift
/// struct Message: Codable {
///     let text: String
///     let timestamp: Date
/// }
///
/// // Store different types in the same array
/// let containers = [
///     try CodableContainer(User(id: 1, name: "Alice")),
///     try CodableContainer(Message(text: "Hello", timestamp: Date()))
/// ]
///
/// // Decode when you know the type
/// let firstUser = try containers[0].decoding(as: User.self)
/// let firstMessage = try containers[1].decoding(as: Message.self)
/// ```
///
/// ### Custom Encoder/Decoder
/// ```swift
/// let encoder = JSONEncoder()
/// encoder.dateEncodingStrategy = .iso8601
///
/// let decoder = JSONDecoder()
/// decoder.dateDecodingStrategy = .iso8601
///
/// let container = try CodableContainer(message, encoder: encoder)
/// let decoded = try container.decoding(as: Message.self, decoder: decoder)
/// ```
///
/// ## Design Philosophy
///
/// `CodableContainer` is intentionally simple and focused:
/// - **Type-safe**: Requires explicit type specification at creation and decoding
/// - **Predictable**: Uses standard JSON encoding/decoding with no magic
/// - **Minimal**: No complex reflection, AnyHashable conversions, or edge case handling
/// - **Explicit**: Clear initialization and decoding methods
///
/// ## Performance Considerations
///
/// - Encoding happens at initialization time
/// - The JSON string is stored in memory
/// - Decoding happens on-demand with no caching
/// - For large objects or frequent decoding, consider caching the decoded result
///
/// ## Thread Safety
///
/// `CodableContainer` conforms to `Sendable`, making it safe to use across concurrency boundaries.
/// The stored JSON string is immutable after initialization.
///
/// ## Comparison with AnyCodable
///
/// Unlike `AnyCodable`, `CodableContainer`:
/// - Does not attempt to preserve the original type at runtime
/// - Requires explicit type specification when decoding
/// - Has no direct value access (must decode first)
/// - Is simpler and more maintainable
/// - Has more predictable behavior
///
/// Choose `CodableContainer` when you:
/// - Need to store/transmit arbitrary `Codable` types
/// - Want type-safe, explicit decoding
/// - Prefer simplicity over convenience
///
/// Choose `AnyCodable` when you:
/// - Need dynamic value access without decoding
/// - Want to work with values of unknown types at runtime
/// - Need to support both `Codable` and non-`Codable` types
///
public struct CodableContainer: Codable, Sendable {
    /// The JSON string representation of the encoded value.
    ///
    /// This property contains the UTF-8 encoded JSON representation of the value
    /// passed to the initializer. It can be used to inspect the encoded data or
    /// for custom serialization scenarios.
    public let encodedString: String

    /// Creates a container by encoding the given value using the default `JSONEncoder`.
    ///
    /// - Parameter value: The `Codable` value to encode and store.
    /// - Throws: An error if encoding fails.
    ///
    /// ## Example
    /// ```swift
    /// struct Point: Codable {
    ///     let x: Int
    ///     let y: Int
    /// }
    ///
    /// let container = try CodableContainer(Point(x: 10, y: 20))
    /// print(container.encodedString) // {"x":10,"y":20}
    /// ```
    public init<T: Codable>(_ value: T) throws {
        let data = try JSONEncoder().encode(value)
        encodedString = String(data: data, encoding: .utf8) ?? ""
    }

    /// Creates a container by encoding the given value using a custom `JSONEncoder`.
    ///
    /// Use this initializer when you need custom encoding behavior, such as:
    /// - Custom date encoding strategies
    /// - Pretty-printed JSON
    /// - Custom key encoding strategies
    ///
    /// - Parameters:
    ///   - value: The `Codable` value to encode and store.
    ///   - encoder: The `JSONEncoder` to use for encoding.
    /// - Throws: An error if encoding fails.
    ///
    /// ## Example
    /// ```swift
    /// struct Event: Codable {
    ///     let name: String
    ///     let date: Date
    /// }
    ///
    /// let encoder = JSONEncoder()
    /// encoder.dateEncodingStrategy = .iso8601
    /// encoder.outputFormatting = .prettyPrinted
    ///
    /// let event = Event(name: "Meeting", date: Date())
    /// let container = try CodableContainer(event, encoder: encoder)
    /// ```
    public init<T: Codable>(_ value: T, encoder: JSONEncoder) throws {
        let data = try encoder.encode(value)
        encodedString = String(data: data, encoding: .utf8) ?? ""
    }

    /// Decodes the stored JSON string into the specified type using the default `JSONDecoder`.
    ///
    /// - Parameter type: The type to decode the stored value as.
    /// - Returns: The decoded value of the specified type.
    /// - Throws: An error if decoding fails or if the stored data is incompatible with the requested type.
    ///
    /// ## Example
    /// ```swift
    /// let container = try CodableContainer(["name": "Alice", "age": 30])
    ///
    /// struct Person: Codable {
    ///     let name: String
    ///     let age: Int
    /// }
    ///
    /// let person = try container.decoding(as: Person.self)
    /// print(person.name) // "Alice"
    /// ```
    public func decoding<T: Codable>(as type: T.Type) throws -> T {
        let data = encodedString.data(using: .utf8) ?? Data()
        return try JSONDecoder().decode(T.self, from: data)
    }

    /// Decodes the stored JSON string into the specified type using a custom `JSONDecoder`.
    ///
    /// Use this method when you need custom decoding behavior, such as:
    /// - Custom date decoding strategies
    /// - Custom key decoding strategies
    /// - Custom data decoding strategies
    ///
    /// - Parameters:
    ///   - type: The type to decode the stored value as.
    ///   - decoder: The `JSONDecoder` to use for decoding.
    /// - Returns: The decoded value of the specified type.
    /// - Throws: An error if decoding fails or if the stored data is incompatible with the requested type.
    ///
    /// ## Example
    /// ```swift
    /// struct Event: Codable {
    ///     let name: String
    ///     let date: Date
    /// }
    ///
    /// let decoder = JSONDecoder()
    /// decoder.dateDecodingStrategy = .iso8601
    ///
    /// let event = try container.decoding(as: Event.self, decoder: decoder)
    /// ```
    public func decoding<T: Codable>(as type: T.Type, decoder: JSONDecoder) throws -> T {
        let data = encodedString.data(using: .utf8) ?? Data()
        return try decoder.decode(T.self, from: data)
    }
}
