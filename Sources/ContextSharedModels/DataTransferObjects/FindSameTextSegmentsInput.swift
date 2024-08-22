import Foundation

public struct FindSameTextSegmentsInput: CoSendable {
    public let segmentId: String?
    public let text: String?

    public init(segmentId: String? = nil, text: String? = nil) {
        self.segmentId = segmentId
        self.text = text
    }
}
