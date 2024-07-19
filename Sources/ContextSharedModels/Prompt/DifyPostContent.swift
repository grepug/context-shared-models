//
//  DifyPostContent.swift
//
//
//  Created by Kai Shao on 2024/7/18.
//

public struct DifyPostContent<I: CoSendable>: CoSendable {
    public let id: String
    public let user: String
    public let inputs: I
    public let response_mode: String

    public init(id: String, user: String, inputs: I, stream: Bool) {
        self.id = id
        self.user = user
        self.inputs = inputs
        self.response_mode = stream ? "streaming" : "block"
    }
}
