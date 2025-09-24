import Foundation

public struct SoundItem: Codable, Hashable, Sendable {
    public enum Audio: Codable, Hashable, Sendable {
        case data(Data)
        case url(URL)
        case storagePath(String)
    }

    public struct RegionItem: Codable, Hashable, Sendable {
        public var symbol: String
        public var audio: Audio

        public init(symbol: String, audio: Audio) {
            self.symbol = symbol
            self.audio = audio
        }
    }

    public var items: [PhoneticSymbolRegion: RegionItem]

    public var isEmpty: Bool {
        items.isEmpty
    }

    public var sortedRegions: [PhoneticSymbolRegion] {
        items.keys.sorted { $0.rawValue < $1.rawValue }
    }

    public func audio(preferredRegion: PhoneticSymbolRegion) -> Audio? {
        if let item = items[preferredRegion] {
            return item.audio
        }

        // Fallback to any available region
        if let firstItem = items.first {
            return firstItem.value.audio
        }

        return nil
    }

    public func region(preferredRegion: PhoneticSymbolRegion) -> PhoneticSymbolRegion? {
        if items[preferredRegion] != nil {
            return preferredRegion
        }

        // Fallback to any available region
        return items.keys.first
    }

    public init(items: [PhoneticSymbolRegion: RegionItem] = [:]) {
        self.items = items
    }

    public static let mock = SoundItem(
        items: [
            .us: RegionItem(symbol: "sʌn", audio: .data(Data(base64Encoded: "UklGRiQAAABXQVZFZm10IBAAAAABAAEAESsAACJWAAACABAAZGF0YQAAAAA=")!)),
            .uk: RegionItem(symbol: "sʌn", audio: .data(Data(base64Encoded: "UklGRiQAAABXQVZFZm10IBAAAAABAAEAESsAACJWAAACABAAZGF0YQAAAAA=")!)),
        ]
    )
}
