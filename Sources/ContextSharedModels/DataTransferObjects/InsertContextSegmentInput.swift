import Foundation

public struct InsertContextSegmentInput: CoSendable {
    public let contextId: UUID
    public let segment: ContextModel.ContextSegment

    public init(contextId: UUID, segment: ContextModel.ContextSegment) {
        self.contextId = contextId
        self.segment = segment
    }
}
