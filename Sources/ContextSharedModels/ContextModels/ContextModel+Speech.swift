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

        public init(
            id: UUID,
            createdAt: Date = .now,
            assetPath: String? = nil,
            text: String = "",
        ) {
            self.id = id
            self.createdAt = createdAt
            self.assetPath = assetPath
            self.text = text
        }

        public init() {
            self.init(id: .init())
        }
    }
}
