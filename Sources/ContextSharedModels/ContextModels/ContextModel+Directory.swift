//
//  ContextModel+Directory.swift
//
//
//  Created by Kai Shao on 2024/5/27.
//

import Foundation

extension ContextModel {
    public struct Directory: ContextModelKind {
        public static var typeName: String {
            "Directory"
        }

        public var id: ID
        public var createdAt: Date
        public var parentID: ID?
        public var title: String
        public var temporary: Bool

        public init(id: ID, createdAt: Date = .now, parentID: ID? = nil, title: String = "", temporary: Bool = false) {
            self.id = id
            self.createdAt = createdAt
            self.parentID = parentID
            self.title = title
            self.temporary = temporary
        }

        public init() {
            self.init(id: UUID().uuidString)
        }
    }
}
