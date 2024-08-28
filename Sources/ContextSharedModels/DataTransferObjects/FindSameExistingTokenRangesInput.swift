struct FindSameExistingTokenRangesInput: CoSendable {
    let text: String

    public init(text: String) {
        self.text = text
    }
}
