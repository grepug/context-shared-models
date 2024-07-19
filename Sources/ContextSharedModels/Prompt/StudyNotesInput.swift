//
//  StudyNotesInput.swift
//
//
//  Created by Kai Shao on 2024/7/18.
//

public struct StudyNotesInput: CoSendable {
    public let text: String
    public let target_language: String

    public init(text: String, target_language: String = "简体中文") {
        self.text = text
        self.target_language = target_language
    }
}
