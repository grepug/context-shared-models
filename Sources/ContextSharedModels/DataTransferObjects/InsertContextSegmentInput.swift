import Foundation

public struct InsertContextSegmentInput: CoSendable {
    public let contextId: String
    public let segment: ContextModel.ContextSegment

    public init(contextId: String, segment: ContextModel.ContextSegment) {
        self.contextId = contextId
        self.segment = segment
    }
}
