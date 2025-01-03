import Foundation

public struct FindSameTextSegmentsInput: CoSendable {
    public let segmentId: UUID?
    public let text: String?

    public init(segmentId: UUID? = nil, text: String? = nil) {
        self.segmentId = segmentId
        self.text = text
    }
}
