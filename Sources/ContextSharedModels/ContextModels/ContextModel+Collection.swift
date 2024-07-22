//
//  ContextModel+Collection.swift
//
//
//  Created by Kai Shao on 2024/5/27.
//

import Foundation

extension ContextModel {
    public struct Collection: ContextModelKind {
        public static var typeName: String {
            "Collection"
        }

        public var id: String
        public var createdAt: Date
        public var title: String
        public var description: String
        public var coverImageURL: URL?
        public var directoryID: ContextModelID?
        public var temporary: Bool

        public init(id: String, createdAt: Date = .now, title: String = "", description: String = "", coverImageURL: URL? = nil, directoryID: ContextModelID? = nil, temporary: Bool = false) {
            self.id = id
            self.createdAt = createdAt
            self.title = title
            self.description = description
            self.coverImageURL = coverImageURL
            self.directoryID = directoryID
            self.temporary = temporary
        }

        public init() {
            self.init(id: Foundation.UUID().uuidString)
        }
    }
}
