import XCTest
@testable import RuString

class RuStringTests: XCTestCase {
    func testComponents() {
        let str = "aaa123bbb123ccc"
        XCTAssertEqual(str.ru.components(separatedBy: "123"), ["aaa", "bbb", "ccc"])

        XCTAssertEqual(str.ru.components(separatedBy: "123", limit: 2), ["aaa", "bbb123ccc"])
    }

    func testComponents2() {
        let str = "aaa\r\nbbb"
        XCTAssertEqual(str.ru.components(separatedBy: ["\n"]), ["aaa\r", "bbb"])
    }

    func testLines() {
        let str = "aaa\nbbb\r\nccc"
        XCTAssertEqual(str.ru.lines(), ["aaa\n", "bbb\r\n", "ccc"])
    }

    func testStrip() {
        let str = "\t  aaaa\r\n"
        XCTAssertEqual(str.ru.strip(), "aaaa")
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
