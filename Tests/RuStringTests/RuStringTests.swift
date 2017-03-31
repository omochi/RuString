import XCTest
@testable import RuString

class RuStringTests: XCTestCase {
    func testSplit() {
        let str = "aaa123bbb123ccc"
        XCTAssertEqual(str.ru.components(separatedBy: "123"), ["aaa", "bbb", "ccc"])

        XCTAssertEqual(str.ru.components(separatedBy: "123", limit: 2), ["aaa", "bbb123ccc"])
    }

    func testFormat() {
        XCTAssertEqual(String.ru.format("%d", 123), "123")

        let text16 = "1234567812345678"
        let text64 = text16 + text16 + text16 + text16

        XCTAssertEqual(
            String.ru.format(
                text64 + text16 + text16 + text16 +
                "1234567812345%d", 999),
            text64 + text16 + text16 + text16 +
            "1234567812345999")
    }
}
