import Foundation

public struct FindSameExistingTokenRangesInput: CoSendable {
    public let text: String
    public let contextId: UUID

    public init(text: String, contextId: UUID) {
        self.text = text
        self.contextId = contextId
    }
}
