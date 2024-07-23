import Foundation

struct InsertContextSegmentInput: CoSendable {
    let contextId: String
    let segment: ContextModel.ContextSegment
}
