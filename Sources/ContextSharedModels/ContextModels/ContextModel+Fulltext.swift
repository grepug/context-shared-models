//
//  Fulltext.swift
//  ContextSharedModels
//
//  Created by Kai Shao on 2024/12/9.
//

import Foundation

extension ContextModel {
    public struct Fulltext: ContextModelKind {
        public init() {
            self.init(id: UUID().uuidString)
        }
        
        public static var typeName: String {
            "Fulltext"
        }
        
        public var id: ID
        public var createdAt: Date
        public var collectionId: ID
        public var html: String
        public var title: String
        public var temporary: Bool = false
        
        public var htmlFilePath = ""
        
        public init(id: ID, createdAt: Date = .now, collectionId: ID = "", htmlFilePath: String = "", html: String = "", title: String = "") {
            self.id = id
            self.createdAt = createdAt
            self.html = html
            self.title = title
            self.collectionId = collectionId
            self.htmlFilePath = htmlFilePath
        }
    }
}
