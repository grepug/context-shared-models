import Foundation

extension ContextModel {
    public struct SegmentReview: UUIDContextModelKind {
        public enum State: String, CoSendable {
            case familiar, unfamiliar
        }

        public static var typeName: String {
            "SegmentReview"
        }

        public var id: UUID
        public var createdAt: Date
        public var segmentId: UUID?
        public var state: State

        public init(id: UUID = .init(), createdAt: Date = .now, state: State = .unfamiliar, segmentId: UUID? = nil) {
            self.id = id
            self.createdAt = createdAt
            self.state = state
            self.segmentId = segmentId
        }

        public init() {
            self.init(id: .init())
        }
    }
}
