//
//  PromptRequest.swift
//
//
//  Created by Kai Shao on 2024/7/18.
//

public protocol CoSendable: Codable, Sendable {}

public struct DifyPromptRequest<Input: CoSendable>: CoSendable {
    public let id: String
    public let stream: Bool
    public let user_id: String
    public let inputs: Input

    public init(id: String, stream: Bool, user_id: String, inputs: Input) {
        self.id = id
        self.stream = stream
        self.user_id = user_id
        self.inputs = inputs
    }
}
