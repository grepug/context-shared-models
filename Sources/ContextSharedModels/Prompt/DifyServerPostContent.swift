//
//  DifyServerPostContent.swift
//
//
//  Created by Kai Shao on 2024/7/18.
//

public struct DifyServerPostContent<I: CoSendable>: CoSendable {
    public let user: String
    public let inputs: I
    public let response_mode: String

    public init(user: String, inputs: I, stream: Bool) {
        self.user = user
        self.inputs = inputs
        self.response_mode = stream ? "streaming" : "block"
    }
}
