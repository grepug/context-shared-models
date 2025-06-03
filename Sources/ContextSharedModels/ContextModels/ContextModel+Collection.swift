//
//  ContextModel+Collection.swift
//
//
//  Created by Kai Shao on 2024/5/27.
//

import Foundation

extension ContextModel {
    public struct Collection: UUIDContextModelKind {
        public enum Cover: String, CoSendable, CaseIterable {
            case `deafult`, dark, light, lighter
        }

        public static var typeName: String {
            "Collection"
        }
        
        public static var localizedName: String {
            "笔记本"
        }

        public var id: UUID
        public var createdAt: Date
        public var title: String
        public var description: String
        public var coverImageURL: URL?
        public var builtInCover: Cover?
        public var directoryID: UUID?
        public var iconKey: String?
        
        public var temporary: Bool

        public init(
            id: UUID,
            createdAt: Date = .now,
            title: String = "",
            iconKey: String? = nil,
            description: String = "",
            coverImageURL: URL? = nil,
            builtInCover cover: Cover? = nil,
            directoryID: UUID? = nil,
            temporary: Bool = false,
        ) {
            self.id = id
            self.createdAt = createdAt
            self.title = title
            self.description = description
            self.coverImageURL = coverImageURL
            self.directoryID = directoryID
            self.temporary = temporary
            self.builtInCover = cover
            self.iconKey = iconKey
        }

        public init() {
            self.init(id: .init())
        }
    }
}
