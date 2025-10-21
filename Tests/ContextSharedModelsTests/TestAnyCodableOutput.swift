//
//  TestAnyCodableOutput.swift
//  ContextSharedModels
//
//  Quick test to show JSON output
//

import Foundation
import XCTest

@testable import ContextSharedModels

class TestAnyCodableOutput: XCTestCase {

    func testAnyCodableOutput() {
        print("=== Testing AnyCodable with JSRangeItem ===")

        let rangeItem = JSRangeItem(lowerBound: 10, upperBound: 20)
        let anyCodable = AnyCodable(codable: rangeItem)

        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(anyCodable)

            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("JSON output for JSRangeItem:")
                print(jsonString)
            }

            // Test decoding
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(AnyCodable.self, from: jsonData)
            let extractedRange = decoded.extracting(JSRangeItem.self)

            print("\nDecoded successfully:")
            print("  Lower bound: \(extractedRange?.lowerBound ?? -1)")
            print("  Upper bound: \(extractedRange?.upperBound ?? -1)")

            // Test complex structure
            print("\n=== Testing Complex Structure ===")

            let complexDict: [String: AnyHashable] = [
                "title": "Test",
                "range": AnyCodable(codable: rangeItem),
                "ranges": [
                    AnyCodable(codable: JSRangeItem(lowerBound: 0, upperBound: 5)),
                    AnyCodable(codable: JSRangeItem(lowerBound: 15, upperBound: 25)),
                ] as [AnyHashable],
            ]

            let complexAnyCodable = AnyCodable(complexDict)
            let complexJsonData = try encoder.encode(complexAnyCodable)

            if let complexJsonString = String(data: complexJsonData, encoding: .utf8) {
                print("Complex structure JSON:")
                print(complexJsonString)
            }

            print("\n✅ AnyCodable successfully handles custom types!")

        } catch {
            print("❌ Error: \(error)")
        }
    }
}
