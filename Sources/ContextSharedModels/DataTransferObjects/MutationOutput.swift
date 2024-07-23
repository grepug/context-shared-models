public struct MutationOutput: CoSendable {
    public let success: Bool

    public init(success: Bool) {
        self.success = success
    }
}
