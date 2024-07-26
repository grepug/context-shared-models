import Foundation

extension ContextModel {
    public struct LocalizedText: ContextModelKind {
        public static var typeName: String {
            "LocalizedText"
        }

        public var id: ID
        public var createdAt: Date
        public var locale: CTLocale
        public var text: String

        public init(id: ID, createdAt: Date = .now, locale: CTLocale = .en, text: String = "") {
            self.id = id
            self.createdAt = createdAt
            self.locale = locale
            self.text = text
        }

        public init() {
            self.init(id: UUID().uuidString)
        }
    }
}
