public enum PhoneticSymbolRegion: String, CoSendable, CodingKeyRepresentable, CaseIterable {
    case uk = "UK"
    case us = "US"

    public var flag: String {
        switch self {
        case .uk: "🇬🇧"
        case .us: "🇺🇸"
        }
    }
    
    var name: String {
        switch self {
        case .uk: "英式"
        case .us: "美式"
        }
    }
}

public typealias PhoniticSymbolDict = [PhoneticSymbolRegion: String]
