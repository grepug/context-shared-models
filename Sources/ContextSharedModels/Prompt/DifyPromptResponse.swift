//
//  DifySSEResponse.swift
//
//
//  Created by Kai Shao on 2024/7/17.
//

public struct DifySSEResponse: CoSendable {
    public let event: String
    public let message_id: String
    public let created_at: Int
    public let task_id: String
    public let id: String
    public let answer: String

    public var internalResponse: PromptInternalResponse<String> {
        return .init(answer: answer, message_id: message_id)
    }
}

extension String: CoSendable {}

public struct PromptInternalResponse<Answer: CoSendable>: CoSendable {
    public let message_id: String?
    public let answer: Answer?

    public init(answer: Answer?, message_id: String? = nil) {
        self.message_id = message_id
        self.answer = answer
    }
}
