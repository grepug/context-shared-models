import Foundation

extension ContextModel {
    public struct SegmentReview: ContextModelKind {
        public enum State: String, CoSendable {
            case familiar, unfamiliar
        }

        public static var typeName: String {
            "SegmentReview"
        }

        public var id: ID
        public var createdAt: Date
        public var segmentId: ID?
        public var state: State

        public init(id: String, createdAt: Date = .now, state: State = .unfamiliar, segmentId: String? = nil) {
            self.id = id
            self.createdAt = createdAt
            self.state = state
            self.segmentId = segmentId
        }

        public init() {
            self.init(id: UUID().uuidString)
        }
    }
}
