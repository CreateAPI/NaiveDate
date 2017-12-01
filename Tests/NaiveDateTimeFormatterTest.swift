// The MIT License (MIT)
//
// Copyright (c) 2017 Alexander Grebenyuk (github.com/kean).

import XCTest
import NaiveDateTime


class NaiveDateFormatterTest: XCTestCase {
    func testNaiveTimeFormatter_enUS() {
        let formatter = NaiveDateFormatter(locale: Locale(identifier: "en_US"), dateStyle: .none, timeStyle: .short)

        XCTAssertEqual(formatter.string(from: NaiveTime("16:10")!), "4:10 PM")
        XCTAssertEqual(formatter.string(from: NaiveTime("16:10:15")!), "4:10 PM")
    }

    func testNaiveTimeFormatter_enGB() {
        let formatter = NaiveDateFormatter(locale: Locale(identifier: "en_GB"), dateStyle: .none, timeStyle: .short)

        XCTAssertEqual(formatter.string(from: NaiveTime("16:10")!), "16:10")
        XCTAssertEqual(formatter.string(from: NaiveTime("16:10:15")!), "16:10")
    }
}
