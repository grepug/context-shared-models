import Foundation

extension ContextModel {
    public struct Speech: UUIDContextModelKind {
        public var cacheState: Int?

        public static var typeName: String {
            "Speech"
        }

        public static var localizedName: String {
            "语音"
        }

        public var id: UUID
        public var createdAt: Date
        public var assetPath: String?
        public var text: String
        public var subtitle: AnyCodable?

        public init(
            id: UUID,
            createdAt: Date = .now,
            assetPath: String? = nil,
            text: String = "",
            subtitle: AnyCodable? = nil
        ) {
            self.id = id
            self.createdAt = createdAt
            self.assetPath = assetPath
            self.text = text
            self.subtitle = subtitle
        }

        public init() {
            self.init(id: .init())
        }
    }
}
