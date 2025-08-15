import Foundation

extension ContextModel {
    public struct PlayItem: UUIDContextModelKind {
        public var cacheState: Int?

        public static var typeName: String {
            "PlayItem"
        }

        public static var localizedName: String {
            "播放项目"
        }

        public var id: UUID
        public var createdAt: Date
        public var speech: Speech?
        public var isStale: Bool
        public var contextId: UUID?

        public var hasAsset: Bool {
            speech?.assetPath != nil
        }

        public init() {
            self.init(id: .init())
        }

        public init(
            id: UUID,
            createdAt: Date = .now,
            speech: Speech? = nil,
            isStale: Bool = false,
            contextId: UUID? = nil
        ) {
            self.id = id
            self.createdAt = createdAt
            self.speech = speech
            self.isStale = isStale
            self.contextId = contextId
        }
    }
}
