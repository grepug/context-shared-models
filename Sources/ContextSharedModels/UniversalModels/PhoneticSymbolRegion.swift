public enum PhoneticSymbolRegion: String, CoSendable, CodingKeyRepresentable, CaseIterable {
    case uk = "UK"
    case us = "US"

    public var flag: String {
        switch self {
        case .uk:
            return "🇬🇧"
        case .us:
            return "🇺🇸"
        }
    }
}

public typealias PhoniticSymbolDict = [PhoneticSymbolRegion: String]
