//
//  Fulltext.swift
//  ContextSharedModels
//
//  Created by Kai Shao on 2024/12/9.
//

import Foundation

extension ContextModel {
    public struct Fulltext: UUIDContextModelKind {
        public init() {
            self.init(id: .init())
        }

        public static var typeName: String {
            "Fulltext"
        }

        public static var localizedName: String {
            "原文"
        }

        public var id: UUID
        public var createdAt: Date
        public var collectionId: UUID
        public var htmlFilePath: String
        public var title: String
        public var temporary: Bool = false
        public var cacheState: Int?

        public init(
            id: UUID,
            createdAt: Date = .now,
            collectionId: UUID = .init(),
            htmlFilePath: String = "",
            html: String = "",
            title: String = "",
            cacheState: Int = 0
        ) {
            self.id = id
            self.createdAt = createdAt
            self.htmlFilePath = htmlFilePath
            self.title = title
            self.collectionId = collectionId
            self.htmlFilePath = htmlFilePath
            self.cacheState = cacheState
        }
    }
}
