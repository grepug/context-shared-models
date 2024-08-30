//
//  ContextModel+Collection.swift
//
//
//  Created by Kai Shao on 2024/5/27.
//

import Foundation

extension ContextModel {
    public struct Collection: ContextModelKind {
        enum Cover: String, ContextModelKind, CaseIterable {
            case `deafult`, dark, light, lighter
        }

        public static var typeName: String {
            "Collection"
        }

        public var id: ID
        public var createdAt: Date
        public var title: String
        public var description: String
        public var coverImageURL: URL?
        public var builtInCover: Cover?
        public var directoryID: ID?
        public var temporary: Bool

        public init(
            id: ID, createdAt: Date = .now, title: String = "", description: String = "", coverImageURL: URL? = nil, builtInCover cover: Cover? = nil, directoryID: ID? = nil, temporary: Bool = false
        ) {
            self.id = id
            self.createdAt = createdAt
            self.title = title
            self.description = description
            self.coverImageURL = coverImageURL
            self.directoryID = directoryID
            self.temporary = temporary
            self.builtInCover = cover
        }

        public init() {
            self.init(id: UUID().uuidString)
        }
    }
}
