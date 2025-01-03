import Foundation

public struct FetchSegmentReviewMetadataInput: CoSendable {
    public let collectionId: UUID
    public let order: SegmentReviewOrder

    public init(collectionId: UUID, order: SegmentReviewOrder) {
        self.collectionId = collectionId
        self.order = order
    }
}

public struct FetchSegmentReviewMetadataOutput: CoSendable {
    public let collectionTitle: String?
    public let familiarSegmentIds: [UUID]
    public let noLatestReviewIds: [UUID]
    public let unfamiliarSegmentIds: [UUID]

    public init(collectionTitle: String?, familiarSegmentIds: [UUID], noLatestReviewIds: [UUID], unfamiliarSegmentIds: [UUID]) {
        self.collectionTitle = collectionTitle
        self.familiarSegmentIds = familiarSegmentIds
        self.noLatestReviewIds = noLatestReviewIds
        self.unfamiliarSegmentIds = unfamiliarSegmentIds
    }
}

public struct UpdateSegmentReviewStateInput: CoSendable {
    public let segmentId: UUID
    public let state: ContextModel.SegmentReview.State
    public let date: Date

    public init(segmentId: UUID, state: ContextModel.SegmentReview.State, date: Date) {
        self.segmentId = segmentId
        self.state = state
        self.date = date
    }
}

public enum SegmentReviewOrder: CaseIterable, CoSendable {
    case random, dateDesc, dateAsc
}
