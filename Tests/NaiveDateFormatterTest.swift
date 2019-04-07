// The MIT License (MIT)
//
// Copyright (c) 2017-2019 Alexander Grebenyuk (github.com/kean).

import XCTest
import NaiveDate


class NaiveDateFormatterTest: XCTestCase {
    func testNaiveTimeFormatter_enUS() {
        let formatter = NaiveDateFormatter {
            $0.locale = Locale(identifier: "en_US")
            $0.timeStyle = .short
        }

        XCTAssertEqual(formatter.string(from: NaiveTime("16:10")!), "4:10 PM")
        XCTAssertEqual(formatter.string(from: NaiveTime("16:10:15")!), "4:10 PM")
    }

    func testNaiveTimeFormatter_enGB() {
        let formatter = NaiveDateFormatter {
            $0.locale = Locale(identifier: "en_GB")
            $0.timeStyle = .short
        }

        XCTAssertEqual(formatter.string(from: NaiveTime("16:10")!), "16:10")
        XCTAssertEqual(formatter.string(from: NaiveTime("16:10:15")!), "16:10")
    }
}
