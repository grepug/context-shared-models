import Foundation

extension ContextModel {
    public struct Entry: ContextModelKind {
        public static var typeName: String {
            "Entry"
        }

        public var id: ID
        public var createdAt: Date
        public var text: String
        public var senses: [ContextModel.EntrySense]

        public init(id: ID, createdAt: Date = .now, text: String = "", senses: [ContextModel.EntrySense] = []) {
            self.id = id
            self.createdAt = createdAt
            self.text = text
            self.senses = senses
        }

        public init() {
            self.init(id: UUID().uuidString)
        }
    }
}

extension Array where Element == ContextModel.EntrySense {
    var dictByPos: [ContextModel.PartOfSpeech: [ContextModel.EntrySense]] {
        Dictionary(grouping: self, by: { $0.pos })
    }
}
