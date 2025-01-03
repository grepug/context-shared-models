//
//  ContextModel+Directory.swift
//
//
//  Created by Kai Shao on 2024/5/27.
//

import Foundation

extension ContextModel {
    public struct Directory: UUIDContextModelKind {
        public static var typeName: String {
            "Directory"
        }
        
        public static var localizedName: String {
            "文件夹"
        }

        public var id: UUID
        public var createdAt: Date
        public var parentID: UUID?
        public var title: String
        public var temporary: Bool

        public init(id: UUID, createdAt: Date = .now, parentID: UUID? = nil, title: String = "", temporary: Bool = false) {
            self.id = id
            self.createdAt = createdAt
            self.parentID = parentID
            self.title = title
            self.temporary = temporary
        }

        public init() {
            self.init(id: .init())
        }
    }
}
