import XCTest
@testable import CRC

final class CRCTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CRC().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
