import Foundation

extension ContextModel {
    public struct Entry: StringIDContextModelKind {
        public static var typeName: String {
            "Entry"
        }

        public var id: String
        public var createdAt: Date
        public var text: String
        public var senses: [ContextModel.EntrySense]

        public var orderedPoses: [ContextModel.PartOfSpeech] {
            var seenPoses = Set<ContextModel.PartOfSpeech>()
            return senses.filter { seenPoses.insert($0.pos).inserted }.map(\.pos)
        }

        public init(id: String, createdAt: Date = .now, text: String = "", senses: [ContextModel.EntrySense] = []) {
            self.id = id
            self.createdAt = createdAt
            self.text = text
            self.senses = senses
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
