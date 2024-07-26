//
//  ContextModel+Context.swift
//
//
//  Created by Kai Shao on 2024/5/27.
//

import Foundation

extension ContextModel {
    public struct Context: ContextModelKind {
        public static var typeName: String {
            "Context"
        }

        public struct SegmentItem: Hashable, CoSendable {
            public var id: ID
            public var segment: ContextModel.ContextSegment.Segment

            public init(id: ID, segment: ContextModel.ContextSegment.Segment) {
                self.id = id
                self.segment = segment
            }
        }

        public var id: ID
        public var createdAt: Date
        public var temporary: Bool
        public var collectionID: ID?
        public var text: String?
        public var imageURL: URL?
        public var segments: [SegmentItem] = []

        public init(id: ID, createdAt: Date = .now, collectionID: ID? = nil, text: String? = nil, imageURL: URL? = nil, segments: [SegmentItem] = [], temporary: Bool = false) {
            self.id = id
            self.createdAt = createdAt
            self.collectionID = collectionID
            self.text = text
            self.imageURL = imageURL
            self.segments = segments
            self.temporary = temporary
        }

        public init() {
            self.init(id: Foundation.UUID().uuidString)
        }

        public init(text: String) {
            self.init(id: Foundation.UUID().uuidString, text: text)
        }
    }
}
