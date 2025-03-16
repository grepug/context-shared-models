import Foundation

public struct FulltextSuggestedResourceItem: Identifiable, Hashable, Codable {
    public let id: String
    public let title: String
    public let url: URL
    public let imageURL: URL
    public let source: String
    public let description: String

    public init(id: String = UUID().uuidString, title: String, url: URL, imageURL: URL, source: String = "", description: String = "") {
        self.id = id
        self.title = title
        self.url = url
        self.imageURL = imageURL
        self.source = source
        self.description = description
    }
}
