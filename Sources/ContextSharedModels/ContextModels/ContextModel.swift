//
//  ContextModels.swift
//
//
//  Created by Kai Shao on 2024/5/27.
//

import Foundation

public enum ContextModelOperation {
    case insert, update, delete
    
    public var localizedDescription: String {
        switch self {
        case .insert: "创建"
        case .update: "修改"
        case .delete: "删除"
        }
    }
}

public struct ContextModelOperationError: LocalizedError {
    let modelKind: any ContextModelKind.Type
    let operation: ContextModelOperation
    
    public var errorDescription: String? {
        "\(modelKind.localizedName) \(operation.localizedDescription) failed"
    }
}

public protocol ContextModelKind: Hashable, Identifiable, CoSendable {
    static var typeName: String { get }

    var id: ID { get set }
    var createdAt: Date { get }
    
    var normalizedID: IDWrapper { get }
    
    static func unwrapId(normalizedID: IDWrapper) -> ID
    static func normalizeId(id: ID) -> IDWrapper
    
    static var localizedName: String { get }
    static func operationError(_ operation: ContextModelOperation) -> LocalizedError
    
    init()
}

public extension ContextModelKind {
    static func operationError(_ operation: ContextModelOperation) -> LocalizedError {
        ContextModelOperationError(modelKind: self, operation: operation)
    }
}

public protocol UUIDContextModelKind: ContextModelKind where ID == UUID {}

extension UUIDContextModelKind {
    public var normalizedID: IDWrapper {
        .uuid(id)
    }
    
    public static func unwrapId(normalizedID: IDWrapper) -> ID {
        guard case let .uuid(uuid) = normalizedID else { fatalError("ID type mismatch") }
        return uuid
    }
    
    public static func normalizeId(id: ID) -> IDWrapper {
        .uuid(id)
    }
}

public protocol StringIDContextModelKind: ContextModelKind where ID == String {}

extension StringIDContextModelKind {
    public var normalizedID: IDWrapper {
        .string(id)
    }
    
    public static func unwrapId(normalizedID: IDWrapper) -> ID {
        guard case let .string(string) = normalizedID else { fatalError("ID type mismatch") }
        return string
    }
    
    public static func normalizeId(id: ID) -> IDWrapper {
        .string(id)
    }
}

extension ContextModelKind {
    public func set<T>(_ keypath: WritableKeyPath<Self, T>, with value: T) -> Self {
        var me = self
        me[keyPath: keypath] = value
        return me
    }
}

public enum IDWrapper: Hashable, CoSendable {
    case uuid(UUID), string(String)
    
    init?(uuid: UUID?) {
        guard let uuid = uuid else { return nil }
        self = .uuid(uuid)
    }
}

public enum ContextModel {
    public typealias StringID = String
}

extension ContextModel {
    public enum TokenTag: CoSendable, Hashable {
        case person, organization, place, date, other
    }

    public protocol TokenKind: CoSendable, Hashable {
        var text: String { get set }
        var range: [Int] { get set }
        var tag: TokenTag? { get set }
        var pos: ContextModel.PartOfSpeech? { get set }
        var lemma: String? { get set }
    }
}

extension ContextModel.TokenKind {
    public mutating func from<T: ContextModel.TokenKind>(_ item: T) {
        text = item.text
        range = item.range
        tag = item.tag
        pos = item.pos
        lemma = item.lemma
    }
}

extension ContextModel {
    public enum PartOfSpeech: String, CoSendable, CaseIterable {
        case noun
        case verb
        case adjective
        case adverb
        case idiom
        case pv
    }

    public struct TokenItem: TokenKind {
        public let id: UUID
        public var text: String
        public var range: [Int]
        public let adjacentText: String
        public var pos: ContextModel.PartOfSpeech?
        public var lemma: String?
        public var tag: TokenTag?
        public var isPunctuation: Bool

        public init(id: UUID = .init(), text: String, range: [Int], adjacentText: String, pos: ContextModel.PartOfSpeech? = nil, lemma: String? = nil, isPunctuation: Bool = false) {
            self.id = id
            self.text = text
            self.range = range
            self.adjacentText = adjacentText
            self.pos = pos
            self.lemma = lemma
            self.isPunctuation = isPunctuation
        }
    }
}
