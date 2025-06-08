import Foundation

extension ContextModel {
    public struct EntrySense: StringIDContextModelKind {
        public static var typeName: String {
            "EntrySense"
        }

        public static var localizedName: String {
            "释义"
        }

        public var id: StringID
        public var createdAt: Date
        public var entryID: StringID?
        public var pos: PartOfSpeech
        public var localizedTexts: [LocalizedText]
        public var examples: [[CTLocale: String]]?
        public var cacheState: Int?

        public init(
            id: StringID,
            createdAt: Date = .now,
            entryID: StringID? = nil,
            pos: PartOfSpeech = .noun,
            localizedTexts: [ContextModel.LocalizedText] = [],
            examples: [[CTLocale: String]]? = nil,
            cacheState: Int = 0
        ) {
            self.id = id
            self.createdAt = createdAt
            self.entryID = entryID
            self.localizedTexts = localizedTexts
            self.pos = pos
            self.examples = examples
            self.cacheState = cacheState
        }

        public init() {
            self.init(id: .init())
        }
    }
}
