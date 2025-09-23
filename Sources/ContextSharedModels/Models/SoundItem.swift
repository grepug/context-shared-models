import Foundation

public struct SoundItem: Codable, Hashable, Sendable {
    public var symbols: PhoniticSymbolDict = .init()
    public var audioData: [PhoneticSymbolRegion: Data] = .init()

    public var isEmpty: Bool {
        symbols.isEmpty || audioData.isEmpty
    }

    public var sortedRegions: [PhoneticSymbolRegion] {
        symbols.keys.sorted { $0.rawValue < $1.rawValue }
    }

    public func audioData(preferredRegion: PhoneticSymbolRegion) -> Data? {
        if let data = audioData[preferredRegion] {
            return data
        }

        // Fallback to any available region
        return audioData.values.first
    }

    public func region(preferredRegion: PhoneticSymbolRegion) -> PhoneticSymbolRegion? {
        if audioData[preferredRegion] != nil {
            return preferredRegion
        }

        // Fallback to any available region
        return audioData.keys.first
    }

    public init(
        symbols: PhoniticSymbolDict = .init(),
        audioData: [PhoneticSymbolRegion: Data] = .init()
    ) {
        self.symbols = symbols
        self.audioData = audioData
    }

    static let mock = SoundItem(
        symbols: [.us: "sʌn", .uk: "sʌn"],
        audioData: [
            .us: Data(base64Encoded: "UklGRiQAAABXQVZFZm10IBAAAAABAAEAESsAACJWAAACABAAZGF0YQAAAAA=")!,
            .uk: Data(base64Encoded: "UklGRiQAAABXQVZFZm10IBAAAAABAAEAESsAACJWAAACABAAZGF0YQAAAAA=")!,
        ]
    )
}
