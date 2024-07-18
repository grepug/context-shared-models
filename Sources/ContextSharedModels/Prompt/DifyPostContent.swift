//
//  DifyPostContent.swift
//
//
//  Created by Kai Shao on 2024/7/18.
//

public struct DifyPostContent<I: CoSendable>: CoSendable {
    public let user: String
    public let inputs: I
    public let response_mode: String

    public init(user: String, inputs: I, response_mode: String = "streaming") {
        self.user = user
        self.inputs = inputs
        self.response_mode = response_mode
    }
}
