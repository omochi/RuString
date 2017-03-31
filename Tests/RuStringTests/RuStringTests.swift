import XCTest
@testable import RuString

class RuStringTests: XCTestCase {
    func testSplit() {
        let str = "aaa123bbb123ccc"
        XCTAssertEqual(str.split(separator: "123"), ["aaa", "bbb", "ccc"])

        XCTAssertEqual(str.split(separator: "123", limit: 2), ["aaa", "bbb123ccc"])
    }
}
