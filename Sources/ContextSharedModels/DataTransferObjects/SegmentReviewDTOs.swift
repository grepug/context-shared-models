import Foundation

public struct FetchSegmentReviewMetadataInput: CoSendable {
    public let collectionId: String
    public let order: SegmentReviewOrder

    public init(collectionId: String, order: SegmentReviewOrder) {
        self.collectionId = collectionId
        self.order = order
    }
}

public struct FetchSegmentReviewMetadataOutput: CoSendable {
    public let collectionTitle: String?
    public let familiarSegmentIds: [String]
    public let noLatestReviewIds: [String]
    public let unfamiliarSegmentIds: [String]

    public init(collectionTitle: String?, familiarSegmentIds: [String], noLatestReviewIds: [String], unfamiliarSegmentIds: [String]) {
        self.collectionTitle = collectionTitle
        self.familiarSegmentIds = familiarSegmentIds
        self.noLatestReviewIds = noLatestReviewIds
        self.unfamiliarSegmentIds = unfamiliarSegmentIds
    }
}

public struct UpdateSegmentReviewStateInput: CoSendable {
    public let segmentId: String
    public let state: ContextModel.SegmentReview.State
    public let date: Date

    public init(segmentId: String, state: ContextModel.SegmentReview.State, date: Date) {
        self.segmentId = segmentId
        self.state = state
        self.date = date
    }
}

public enum SegmentReviewOrder: CaseIterable, CoSendable {
    case random, dateDesc, dateAsc
}
