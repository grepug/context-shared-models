import Foundation

extension ContextModel {
    public struct LocalizedText: StringIDContextModelKind {
        public static var typeName: String {
            "LocalizedText"
        }

        public static var localizedName: String {
            "Localized Text"
        }

        public var id: String
        public var createdAt: Date
        public var locale: CTLocale
        public var text: String
        public var cacheState: Int?

        public init(
            id: String,
            createdAt: Date = .now,
            locale: CTLocale = .en,
            text: String = "",
            cacheState: Int = 0
        ) {
            self.id = id
            self.createdAt = createdAt
            self.locale = locale
            self.text = text
            self.cacheState = cacheState
        }

        public init() {
            self.init(id: .init())
        }
    }
}
