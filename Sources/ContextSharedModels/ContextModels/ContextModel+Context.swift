//
//  ContextModel+Context.swift
//
//
//  Created by Kai Shao on 2024/5/27.
//

import Foundation

extension ContextModel {
    public struct Context: UUIDContextModelKind {
        public static var typeName: String {
            "Context"
        }
        
        public static var localizedName: String {
            "语境"
        }

        public struct SegmentItem: Hashable, CoSendable {
            public var id: ID
            public var segment: ContextModel.ContextSegment.Segment

            public init(id: ID, segment: ContextModel.ContextSegment.Segment) {
                self.id = id
                self.segment = segment
            }
        }
        
        public struct FulltextItem: Hashable, CoSendable {
            public var id: ID
            public var title: String
            public var range: JSRange
            
            public var rangeString: String? {
                try? range.toString()
            }

            public init(id: ID, title: String = "", range: JSRange) {
                self.id = id
                self.title = title
                self.range = range
            }
        }

        public var id: UUID
        public var createdAt: Date
        public var temporary: Bool
        public var collectionID: UUID?
        public var collectionTitle: String?
        public var text: String?
        public var imageURL: URL?
        public var segments: [SegmentItem] = []
        
        public var fulltextItem: FulltextItem?
        
        public init(id: UUID, createdAt: Date = .now, collectionID: UUID? = nil, text: String? = nil, imageURL: URL? = nil, segments: [SegmentItem] = [], temporary: Bool = false) {
            self.id = id
            self.createdAt = createdAt
            self.collectionID = collectionID
            self.text = text
            self.imageURL = imageURL
            self.segments = segments
            self.temporary = temporary
        }

        public init() {
            self.init(id: .init())
        }

        public init(text: String) {
            self.init(id: .init(), text: text)
        }
    }
}
