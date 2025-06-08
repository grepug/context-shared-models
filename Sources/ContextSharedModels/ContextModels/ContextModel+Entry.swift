import Foundation

extension ContextModel {
    public struct Entry: StringIDContextModelKind {
        public static var typeName: String {
            "Entry"
        }

        public static var localizedName: String {
            "词条"
        }

        public var id: String
        public var createdAt: Date
        public var text: String
        public var senses: [ContextModel.EntrySense]
        public var cacheState: Int?

        public var orderedPoses: [ContextModel.PartOfSpeech] {
            var seenPoses = Set<ContextModel.PartOfSpeech>()
            return senses.filter { seenPoses.insert($0.pos).inserted }.map(\.pos)
        }

        public init(
            id: String,
            createdAt: Date = .now,
            text: String = "",
            senses: [ContextModel.EntrySense] = [],
            cacheState: Int = 0,
        ) {
            self.id = id
            self.createdAt = createdAt
            self.text = text
            self.senses = senses
            self.cacheState = cacheState
        }

        public init() {
            self.init(id: .init())
        }
    }
}

extension Array where Element == ContextModel.EntrySense {
    var dictByPos: [ContextModel.PartOfSpeech: [ContextModel.EntrySense]] {
        Dictionary(grouping: self, by: { $0.pos })
    }
}
