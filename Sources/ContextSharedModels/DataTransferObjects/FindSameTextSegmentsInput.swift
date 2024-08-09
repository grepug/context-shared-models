import Foundation

public struct FindSameTextSegmentsInput: CoSendable {
    public let segmentId: String

    public init(segmentId: String) {
        self.segmentId = segmentId
    }
}
