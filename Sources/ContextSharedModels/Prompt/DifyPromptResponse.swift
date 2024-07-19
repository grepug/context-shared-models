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
}

public struct PromptInternalResponse<Answer: Codable>: Codable {
    public let message_id: String?
    public let answer: Answer?

    public init(message_id: String?, answer: Answer?) {
        self.message_id = message_id
        self.answer = answer
    }
}
