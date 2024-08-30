public struct FindSameExistingTokenRangesInput: CoSendable {
    public let text: String
    public let contextId: String

    public init(text: String, contextId: String) {
        self.text = text
        self.contextId = contextId
    }
}
