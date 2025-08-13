import Foundation

public enum FreeFeature: String, CaseIterable {
    case importFulltext
    case addContextSegment
    case contextTranslation
    case contextStudyNote
    case segmentStudyNote

    public var countLimit: Int {
        switch self {
        case .importFulltext: 5
        case .addContextSegment: 100
        case .contextTranslation: 3
        case .contextStudyNote: 3
        case .segmentStudyNote: 10
        }
    }

    public var localizedName: String {
        switch self {
        case .importFulltext: "导入文章"
        case .addContextSegment: "添加生词"
        case .contextTranslation: "翻译"
        case .contextStudyNote: "语法"
        case .segmentStudyNote: "单词学习"
        }
    }
}

public struct FreeFeatureLimitInfo {
    public var featureCanUse: [FreeFeature: Bool]
    public var featureNextAvailableDate: [FreeFeature: Date?]

    public init() {
        featureCanUse = [:]
        featureNextAvailableDate = [:]
    }
}
