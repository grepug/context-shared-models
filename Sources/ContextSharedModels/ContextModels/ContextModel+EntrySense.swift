import Foundation

extension ContextModel {
    public struct EntrySense: ContextModelKind {
        public static var typeName: String {
            "EntrySense"
        }

        public var id: String
        public var createdAt: Date
        public var entryID: String?
        public var pos: PartOfSpeech
        public var localizedTexts: [ContextModel.LocalizedText]

        public init(id: String, createdAt: Date = .now, entryID: String? = nil, pos: PartOfSpeech = .noun, localizedTexts: [ContextModel.LocalizedText] = []) {
            self.id = id
            self.createdAt = createdAt
            self.entryID = entryID
            self.localizedTexts = localizedTexts
            self.pos = pos
        }

        public init() {
            self.init(id: Foundation.UUID().uuidString)
        }
    }
}
