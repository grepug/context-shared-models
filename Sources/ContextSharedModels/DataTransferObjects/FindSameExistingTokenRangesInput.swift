public struct FindSameExistingTokenRangesInput: CoSendable {
    let text: String
    let contextId: String

    public init(text: String, contextId: String) {
        self.text = text
        self.contextId = contextId
    }
}
