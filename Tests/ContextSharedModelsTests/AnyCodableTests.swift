//
//  AnyCodableTests.swift
//  ContextSharedModelsTests
//
//  Created on 2025/10/21.
//

import XCTest

@testable import ContextSharedModels

struct JSRangeItem: Codable, Sendable, Hashable {
    let lowerBound: Int
    let upperBound: Int

    init(lowerBound: Int, upperBound: Int) {
        self.lowerBound = lowerBound
        self.upperBound = upperBound
    }
}

final class AnyCodableTests: XCTestCase {

    func testBasicTypes() throws {
        // Test with basic types
        let intValue = AnyCodable(42)
        let stringValue = AnyCodable("hello")
        let boolValue = AnyCodable(true)
        let doubleValue = AnyCodable(3.14)

        XCTAssertEqual(intValue.value as? Int, 42)
        XCTAssertEqual(stringValue.value as? String, "hello")
        XCTAssertEqual(boolValue.value as? Bool, true)
        XCTAssertEqual(doubleValue.value as? Double, 3.14)
    }

    func testCustomCodableType() throws {
        // Test with JSRangeItem
        let originalRange = JSRangeItem(lowerBound: 10, upperBound: 20)
        let anyCodable = AnyCodable(codable: originalRange)

        // Verify the value is stored
        XCTAssertNotNil(anyCodable.value)

        // Test encoding and decoding using the built-in decoding method
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()

        let data = try encoder.encode(anyCodable)

        // Verify we actually encoded something
        XCTAssertGreaterThan(data.count, 0)

        // Verify the JSON structure
        let jsonObject = try JSONSerialization.jsonObject(with: data)
        XCTAssertNotNil(jsonObject)

        // Decode back to AnyCodable
        let decoded = try decoder.decode(AnyCodable.self, from: data)

        // Test using the decoding method directly with default encoder/decoder
        let decodedRange1 = try decoded.decoding(as: JSRangeItem.self)
        XCTAssertEqual(decodedRange1.lowerBound, 10, "Decoding method failed - lower bound doesn't match")
        XCTAssertEqual(decodedRange1.upperBound, 20, "Decoding method failed - upper bound doesn't match")

        // Test using the decoding method with custom encoder/decoder
        let customEncoder = JSONEncoder()
        customEncoder.outputFormatting = .prettyPrinted
        let customDecoder = JSONDecoder()

        let decodedRange2 = try decoded.decoding(as: JSRangeItem.self, encoder: customEncoder, decoder: customDecoder)
        XCTAssertEqual(decodedRange2.lowerBound, 10, "Custom decoding method failed - lower bound doesn't match")
        XCTAssertEqual(decodedRange2.upperBound, 20, "Custom decoding method failed - upper bound doesn't match")

        // Compare with extracting method
        let extractedRange = decoded.extracting(JSRangeItem.self)
        XCTAssertNotNil(extractedRange, "Failed to extract JSRangeItem from decoded AnyCodable")
        XCTAssertEqual(extractedRange?.lowerBound, decodedRange1.lowerBound, "Extracting and decoding should give same result")
        XCTAssertEqual(extractedRange?.upperBound, decodedRange1.upperBound, "Extracting and decoding should give same result")

        // Also test that we can get the JSON string representation
        let jsonString = String(data: data, encoding: .utf8)
        XCTAssertNotNil(jsonString)
        XCTAssertTrue(jsonString!.contains("lowerBound"), "JSON should contain lowerBound field")
        XCTAssertTrue(jsonString!.contains("upperBound"), "JSON should contain upperBound field")
    }

    func testArrayOfCustomTypes() throws {
        let range1 = JSRangeItem(lowerBound: 0, upperBound: 5)
        let range2 = JSRangeItem(lowerBound: 10, upperBound: 15)

        let array = [AnyCodable(codable: range1), AnyCodable(codable: range2)]
        let anyCodableArray = AnyCodable(array as [AnyHashable])

        let encoder = JSONEncoder()
        let decoder = JSONDecoder()

        // Test encoding
        let data = try encoder.encode(anyCodableArray)
        XCTAssertGreaterThan(data.count, 0, "Should have encoded data")

        // Verify JSON structure
        let jsonString = String(data: data, encoding: .utf8)
        XCTAssertNotNil(jsonString)
        XCTAssertTrue(jsonString!.contains("lowerBound"), "JSON should contain lowerBound fields")
        XCTAssertTrue(jsonString!.contains("upperBound"), "JSON should contain upperBound fields")

        // Test decoding
        let decoded = try decoder.decode(AnyCodable.self, from: data)
        XCTAssertNotNil(decoded.value, "Decoded value should not be nil")

        // Verify we can extract the array
        if let decodedArray = decoded.value as? [AnyHashable] {
            XCTAssertEqual(decodedArray.count, 2, "Should have 2 items in decoded array")
        } else {
            XCTFail("Failed to decode as array")
        }

        // Test decoding the array as a whole using decoding method
        // First create a wrapper struct for the array
        struct RangeArray: Codable {
            let ranges: [JSRangeItem]
        }

        let rangeArrayStruct = RangeArray(ranges: [range1, range2])
        let rangeArrayAnyCodable = AnyCodable(codable: rangeArrayStruct)

        // Test decoding with custom encoder settings
        let arrayEncoder = JSONEncoder()
        arrayEncoder.outputFormatting = .prettyPrinted
        let arrayDecoder = JSONDecoder()

        let decodedRangeArray = try rangeArrayAnyCodable.decoding(as: RangeArray.self, encoder: arrayEncoder, decoder: arrayDecoder)

        XCTAssertEqual(decodedRangeArray.ranges.count, 2, "Decoded array should have 2 ranges")
        XCTAssertEqual(decodedRangeArray.ranges[0].lowerBound, 0, "First range lower bound should be 0")
        XCTAssertEqual(decodedRangeArray.ranges[0].upperBound, 5, "First range upper bound should be 5")
        XCTAssertEqual(decodedRangeArray.ranges[1].lowerBound, 10, "Second range lower bound should be 10")
        XCTAssertEqual(decodedRangeArray.ranges[1].upperBound, 15, "Second range upper bound should be 15")

        print("✅ Successfully tested array decoding with decoding method")
    }

    func testDictionaryWithCustomTypes() throws {
        let rangeItem = JSRangeItem(lowerBound: 100, upperBound: 200)
        let dict: [String: AnyHashable] = [
            "name": "test",
            "count": 42,
            "range": AnyCodable(codable: rangeItem),
        ]

        let anyCodableDict = AnyCodable(dict)

        let encoder = JSONEncoder()
        let decoder = JSONDecoder()

        // Test encoding
        let data = try encoder.encode(anyCodableDict)
        XCTAssertGreaterThan(data.count, 0, "Should have encoded data")

        // Verify JSON structure
        let jsonString = String(data: data, encoding: .utf8)
        XCTAssertNotNil(jsonString)
        XCTAssertTrue(jsonString!.contains("name"), "JSON should contain name field")
        XCTAssertTrue(jsonString!.contains("test"), "JSON should contain test value")
        XCTAssertTrue(jsonString!.contains("count"), "JSON should contain count field")
        XCTAssertTrue(jsonString!.contains("42"), "JSON should contain count value")
        XCTAssertTrue(jsonString!.contains("range"), "JSON should contain range field")
        XCTAssertTrue(jsonString!.contains("lowerBound"), "JSON should contain lowerBound in range")
        XCTAssertTrue(jsonString!.contains("upperBound"), "JSON should contain upperBound in range")

        // Test decoding
        let decoded = try decoder.decode(AnyCodable.self, from: data)
        XCTAssertNotNil(decoded.value, "Decoded value should not be nil")

        // Verify we can extract the dictionary
        if let decodedDict = decoded.value as? [String: AnyHashable] {
            XCTAssertEqual(decodedDict["name"] as? String, "test", "Name should match")
            XCTAssertEqual(decodedDict["count"] as? Int, 42, "Count should match")
            XCTAssertNotNil(decodedDict["range"], "Range should exist in decoded dict")
        } else {
            XCTFail("Failed to decode as dictionary")
        }
    }

    func testRoundTripWithMultipleCustomTypes() throws {
        // Test with multiple different custom types in a complex structure
        let range1 = JSRangeItem(lowerBound: 10, upperBound: 20)
        let range2 = JSRangeItem(lowerBound: 30, upperBound: 40)

        let complexStructure: [String: AnyHashable] = [
            "title": "Complex Test",
            "version": 1.5,
            "isActive": true,
            "ranges": [
                AnyCodable(codable: range1),
                AnyCodable(codable: range2),
            ] as [AnyHashable],
            "metadata": [
                "primaryRange": AnyCodable(codable: range1),
                "secondaryRange": AnyCodable(codable: range2),
                "count": 2,
            ] as [String: AnyHashable],
        ]

        let anyCodable = AnyCodable(complexStructure)

        // Encode
        let encoder = JSONEncoder()
        let data = try encoder.encode(anyCodable)

        // Verify we have substantial data
        XCTAssertGreaterThan(data.count, 100, "Should have substantial encoded data")

        // Decode
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(AnyCodable.self, from: data)

        // Verify the complete structure
        guard let decodedDict = decoded.value as? [String: AnyHashable] else {
            XCTFail("Failed to decode as dictionary")
            return
        }

        XCTAssertEqual(decodedDict["title"] as? String, "Complex Test")
        if let version = decodedDict["version"] as? Double {
            XCTAssertEqual(version, 1.5, accuracy: 0.001)
        } else {
            XCTFail("Version should be a Double")
        }
        XCTAssertEqual(decodedDict["isActive"] as? Bool, true)

        // Verify arrays are present
        XCTAssertNotNil(decodedDict["ranges"])
        XCTAssertNotNil(decodedDict["metadata"])

        print("✅ Successfully encoded and decoded complex structure with custom types")
    }

    func testDecodingMethodWithDifferentConfigurations() throws {
        // Create test data with various custom types
        let range1 = JSRangeItem(lowerBound: 5, upperBound: 15)
        let range2 = JSRangeItem(lowerBound: 25, upperBound: 35)

        // Test decoding with default JSONEncoder/JSONDecoder
        let anyCodable1 = AnyCodable(codable: range1)
        let decoded1 = try anyCodable1.decoding(as: JSRangeItem.self)

        XCTAssertEqual(decoded1.lowerBound, 5, "Default decoding failed")
        XCTAssertEqual(decoded1.upperBound, 15, "Default decoding failed")

        // Test decoding with custom formatting
        let prettyEncoder = JSONEncoder()
        prettyEncoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let strictDecoder = JSONDecoder()

        let anyCodable2 = AnyCodable(codable: range2)
        let decoded2 = try anyCodable2.decoding(as: JSRangeItem.self, encoder: prettyEncoder, decoder: strictDecoder)

        XCTAssertEqual(decoded2.lowerBound, 25, "Pretty formatted decoding failed")
        XCTAssertEqual(decoded2.upperBound, 35, "Pretty formatted decoding failed")

        // Test decoding with date formatting (create a custom type with dates)
        struct DateRange: Codable, Hashable {
            let startDate: Date
            let endDate: Date
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        let dateEncoder = JSONEncoder()
        dateEncoder.dateEncodingStrategy = .formatted(dateFormatter)
        let dateDecoder = JSONDecoder()
        dateDecoder.dateDecodingStrategy = .formatted(dateFormatter)

        let testDate1 = dateFormatter.date(from: "2025-01-01")!
        let testDate2 = dateFormatter.date(from: "2025-12-31")!
        let dateRange = DateRange(startDate: testDate1, endDate: testDate2)

        // Create AnyCodable using the same encoder strategy to ensure consistency
        let anyCodableDateRange = try AnyCodable(codable: dateRange, encoder: dateEncoder)

        // Use consistent encoder/decoder for the date test
        let decodedDateRange = try anyCodableDateRange.decoding(as: DateRange.self, encoder: dateEncoder, decoder: dateDecoder)

        // Compare with some tolerance since date comparison can be tricky
        let calendar = Calendar(identifier: .gregorian)
        let date1Components = calendar.dateComponents([.year, .month, .day], from: decodedDateRange.startDate)
        let date2Components = calendar.dateComponents([.year, .month, .day], from: decodedDateRange.endDate)

        XCTAssertEqual(date1Components.year, 2025, "Start year should be 2025")
        XCTAssertEqual(date1Components.month, 1, "Start month should be 1")
        XCTAssertEqual(date1Components.day, 1, "Start day should be 1")
        XCTAssertEqual(date2Components.year, 2025, "End year should be 2025")
        XCTAssertEqual(date2Components.month, 12, "End month should be 12")
        XCTAssertEqual(date2Components.day, 31, "End day should be 31")

        print("✅ Successfully tested decoding method with different configurations")
    }

    func testDecodingMethodErrorHandling() throws {
        // Create AnyCodable with basic type
        let stringAnyCodable = AnyCodable("not a range")

        // This should throw an error when trying to decode as JSRangeItem
        XCTAssertThrowsError(try stringAnyCodable.decoding(as: JSRangeItem.self)) { error in
            print("Expected error when decoding string as JSRangeItem: \(error)")
        }

        // Test with nil value
        let nilAnyCodable = AnyCodable(nil as String?)
        XCTAssertThrowsError(try nilAnyCodable.decoding(as: JSRangeItem.self)) { error in
            print("Expected error when decoding nil as JSRangeItem: \(error)")
        }

        // Test with complex structure that should work
        let validRange = JSRangeItem(lowerBound: 1, upperBound: 10)
        let validAnyCodable = AnyCodable(codable: validRange)

        // This should NOT throw an error
        XCTAssertNoThrow(try validAnyCodable.decoding(as: JSRangeItem.self))
        let decoded = try validAnyCodable.decoding(as: JSRangeItem.self)
        XCTAssertEqual(decoded.lowerBound, 1)
        XCTAssertEqual(decoded.upperBound, 10)

        print("✅ Successfully tested decoding method error handling")
    }

    func testDecodingMethodVsExtractingMethod() throws {
        // Test to compare decoding method vs extracting method behavior
        let originalRange = JSRangeItem(lowerBound: 100, upperBound: 200)
        let anyCodable = AnyCodable(codable: originalRange)

        // Encode and decode to simulate real-world usage
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        let data = try encoder.encode(anyCodable)
        let decoded = try decoder.decode(AnyCodable.self, from: data)

        // Test both methods
        let decodedViaDecoding = try decoded.decoding(as: JSRangeItem.self)
        let decodedViaExtracting = decoded.extracting(JSRangeItem.self)

        // Both should give the same results
        XCTAssertNotNil(decodedViaExtracting, "Extracting method should not return nil")
        XCTAssertEqual(decodedViaDecoding.lowerBound, decodedViaExtracting!.lowerBound, "Both methods should give same lower bound")
        XCTAssertEqual(decodedViaDecoding.upperBound, decodedViaExtracting!.upperBound, "Both methods should give same upper bound")

        // Test performance difference (decoding throws errors, extracting returns nil)
        let invalidAnyCodable = AnyCodable("invalid")

        // Decoding should throw
        XCTAssertThrowsError(try invalidAnyCodable.decoding(as: JSRangeItem.self)) { error in
            print("Expected error when decoding invalid string: \(error)")
        }

        // Extracting should return nil (it tries both direct cast and decoding internally)
        let extractedInvalid = invalidAnyCodable.extracting(JSRangeItem.self)
        XCTAssertNil(extractedInvalid, "Extracting invalid data should return nil")

        print("✅ Successfully compared decoding vs extracting methods")
    }
}
