import Foundation

extension ContextModel {
    public struct EntrySense: ContextModelKind {
        public static var typeName: String {
            "EntrySense"
        }

        public var id: ID
        public var createdAt: Date
        public var entryID: String?
        public var pos: PartOfSpeech
        public var localizedTexts: [LocalizedText]
        public var examples: [[CTLocale: String]]?

        public init(id: ID, createdAt: Date = .now, entryID: ID? = nil, pos: PartOfSpeech = .noun, localizedTexts: [ContextModel.LocalizedText] = [], examples: [[CTLocale: String]]? = nil) {
            self.id = id
            self.createdAt = createdAt
            self.entryID = entryID
            self.localizedTexts = localizedTexts
            self.pos = pos
            self.examples = examples
        }

        public init() {
            self.init(id: UUID().uuidString)
        }
    }
}
