import Foundation

extension Encodable {
    public func toString() throws -> String {
        do {
            return String(data: try JSONEncoder().encode(self), encoding: .utf8)!
        } catch {
            throw error
        }
    }

    public func toData() throws -> Data {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            throw error
        }
    }
}

extension Decodable {
    public static func fromData(_ data: Data) throws -> Self {
        do {
            return try JSONDecoder().decode(Self.self, from: data)
        } catch {
            print("decoding error: \(error)", "string: \(String(data: data, encoding: .utf8) ?? "no string")")

            throw error
        }
    }

    public static func fromString(_ string: String) throws -> Self {
        do {
            return try Self.fromData(Data(string.utf8))
        } catch {
            throw error
        }
    }
}
