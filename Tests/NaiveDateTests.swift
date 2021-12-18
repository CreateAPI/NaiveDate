// The MIT License (MIT)
//
// Copyright (c) 2017-2021 Alexander Grebenyuk (github.com/kean).

import Foundation
import XCTest
import NaiveDate

// MARK: - NaiveDate -

class NaiveDateTest: XCTestCase {
    // MARK: Equatable, Hashable, Comparable

    func testEquatable() {
        XCTAssertNotEqual(NaiveDate(year: 2017, month: 10, day: 1), NaiveDate(year: 2018, month: 10, day: 1))
        XCTAssertNotEqual(NaiveDate(year: 2017, month: 10, day: 1), NaiveDate(year: 2017, month: 11, day: 1))
        XCTAssertNotEqual(NaiveDate(year: 2017, month: 10, day: 1), NaiveDate(year: 2017, month: 10, day: 2))
        XCTAssertEqual(NaiveDate(year: 2017, month: 10, day: 1), NaiveDate(year: 2017, month: 10, day: 1))
    }

    func testHashable() {
        XCTAssertNotEqual(NaiveDate(year: 2017, month: 10, day: 1).hashValue, NaiveDate(year: 2018, month: 10, day: 1).hashValue)
        XCTAssertNotEqual(NaiveDate(year: 2017, month: 10, day: 1).hashValue, NaiveDate(year: 2017, month: 11, day: 1).hashValue)
        XCTAssertNotEqual(NaiveDate(year: 2017, month: 10, day: 1).hashValue, NaiveDate(year: 2017, month: 10, day: 2).hashValue)
        XCTAssertEqual(NaiveDate(year: 2017, month: 10, day: 1).hashValue, NaiveDate(year: 2017, month: 10, day: 1).hashValue)
    }

    func testComparable() {
        XCTAssertLessThan(NaiveDate(year: 2017, month: 10, day: 1), NaiveDate(year: 2018, month: 10, day: 1))
        XCTAssertLessThan(NaiveDate(year: 2017, month: 10, day: 1), NaiveDate(year: 2017, month: 11, day: 1))
        XCTAssertLessThan(NaiveDate(year: 2017, month: 10, day: 1), NaiveDate(year: 2017, month: 10, day: 2))
        XCTAssertEqual(NaiveDate(year: 2017, month: 10, day: 1), NaiveDate(year: 2017, month: 10, day: 1))
    }

    // MARK: LosslessStringConvertible

    func testFromString() {
        XCTAssertNil(NaiveDate("2017"))
        XCTAssertNil(NaiveDate("2017-10"))
        XCTAssertNil(NaiveDate("2017-AA-10-01"))
        XCTAssertNil(NaiveDate(" 2017-10-01"))
        XCTAssertNil(NaiveDate("2017- 10-01"))
        XCTAssertNil(NaiveDate("2017:10:01"))

        XCTAssertEqual(NaiveDate("2017-10-01"), NaiveDate(year: 2017, month: 10, day: 1))
        XCTAssertEqual(NaiveDate("2017-10-1"), NaiveDate(year: 2017, month: 10, day: 1))
    }

    func testToString() {
        XCTAssertEqual(NaiveDate(year: 2017, month: 10, day: 1).description, "2017-10-01")
    }

    // MARK: Codable

    private struct Wrapped: Codable {
        let date: NaiveDate
    }

    func testDecodable() {
        let date = try! JSONDecoder().decode(Wrapped.self, from: "{\"date\":\"2017-02-01\"}".data(using: .utf8)!)
        XCTAssertEqual(date.date, NaiveDate(year: 2017, month: 2, day: 1))
    }

    func testEncodable() {
        let data = try! JSONEncoder().encode(Wrapped(date: NaiveDate(year: 2017, month: 2, day: 1)))
        XCTAssertEqual(String(data: data, encoding: .utf8), "{\"date\":\"2017-02-01\"}")
    }

    // MARK: Date, DateComponents

    func testFromDate() {
        let date = ISO8601DateFormatter().date(from: "2017-12-01T12:00:00Z")!
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "GMT")!
        XCTAssertEqual(
            calendar.naiveDate(from: date),
            NaiveDate("2017-12-01")
        )
    }

    func testToDate() {
        test("converting to date in calendar's time zone") {
            let date = NaiveDate(year: 2017, month: 10, day: 1)

            var calendar = Calendar.current
            calendar.timeZone = TimeZone(secondsFromGMT: 3600)!

            XCTAssertEqual(
                calendar.date(from: date),
                _date(from: "2017-10-01T00:00:00+0100")
            )
        }
    }

    func testToDateComponents() {
        XCTAssertEqual(
            NaiveDate(year: 2017, month: 10, day: 1).dateComponents,
            DateComponents(year: 2017, month: 10, day: 1)
        )
    }
}


// MARK: - NaiveTime -

class NaiveTimeTest: XCTestCase {
    // MARK: Equatable, Hashable, Comparable

    func testEquatable() {
        XCTAssertNotEqual(NaiveTime(hour: 21, minute: 15, second: 10), NaiveTime(hour: 22, minute: 15, second: 10))
        XCTAssertNotEqual(NaiveTime(hour: 21, minute: 15, second: 10), NaiveTime(hour: 21, minute: 16, second: 10))
        XCTAssertNotEqual(NaiveTime(hour: 21, minute: 15, second: 10), NaiveTime(hour: 21, minute: 15, second: 11))
        XCTAssertEqual(NaiveTime(hour: 21, minute: 15, second: 10), NaiveTime(hour: 21, minute: 15, second: 10))
    }

    func testHashable() {
        XCTAssertNotEqual(NaiveTime(hour: 21, minute: 15, second: 10).hashValue, NaiveTime(hour: 22, minute: 15, second: 10).hashValue)
        XCTAssertNotEqual(NaiveTime(hour: 21, minute: 15, second: 10).hashValue, NaiveTime(hour: 21, minute: 16, second: 10).hashValue)
        XCTAssertNotEqual(NaiveTime(hour: 21, minute: 15, second: 10).hashValue, NaiveTime(hour: 21, minute: 15, second: 11).hashValue)
        XCTAssertEqual(NaiveTime(hour: 21, minute: 15, second: 10).hashValue, NaiveTime(hour: 21, minute: 15, second: 10).hashValue)
    }

    func testComparable() {
        XCTAssertLessThan(NaiveTime(hour: 21, minute: 15, second: 10), NaiveTime(hour: 22, minute: 15, second: 10))
        XCTAssertLessThan(NaiveTime(hour: 21, minute: 15, second: 10), NaiveTime(hour: 21, minute: 16, second: 10))
        XCTAssertLessThan(NaiveTime(hour: 21, minute: 15, second: 10), NaiveTime(hour: 21, minute: 15, second: 11))
        XCTAssertEqual(NaiveTime(hour: 21, minute: 15, second: 10), NaiveTime(hour: 21, minute: 15, second: 10))
    }

    // MARK: Time Interval

    func funcInitWithTotalSeconds() {
        XCTAssertEqual(NaiveTime(timeInterval: 605), NaiveTime(minute: 10, second: 5))
        XCTAssertEqual(NaiveTime(timeInterval: 3600), NaiveTime(hour: 1))
        XCTAssertEqual(NaiveTime(timeInterval: 3610), NaiveTime(hour: 1, second: 10))
    }

    func testTotalSeconds() {
        XCTAssertEqual(NaiveTime(minute: 10, second: 5).timeInterval, 605)
        XCTAssertEqual(NaiveTime(hour: 1).timeInterval, 3600)
        XCTAssertEqual(NaiveTime(hour: 1, second: 10).timeInterval, 3610)
    }

    // MARK: LosslessStringConvertible

    func testFromString() {
        XCTAssertNil(NaiveTime("AA"))
        XCTAssertNil(NaiveTime(""))
        XCTAssertNil(NaiveTime("23:AA"))
        XCTAssertNil(NaiveTime("23-59"))
        XCTAssertNil(NaiveTime("23"))
        XCTAssertNil(NaiveTime("23:AA:59:59"))

        XCTAssertNil(NaiveTime(" 23:59:59"))
        XCTAssertNil(NaiveTime("23:59:59 "))
        XCTAssertNil(NaiveTime("23:59 :59"))

        XCTAssertEqual(NaiveTime("23:59:59"), NaiveTime(hour: 23, minute: 59, second: 59))
        XCTAssertEqual(NaiveTime("23:59"), NaiveTime(hour: 23, minute: 59, second: 0))
    }

    func testToString() {
        XCTAssertEqual(NaiveTime(hour: 23, minute: 59, second: 59).description, "23:59:59")
        XCTAssertEqual(NaiveTime(hour: 23, minute: 59, second: 0).description, "23:59:00")
        XCTAssertEqual(NaiveTime(hour: 23, minute: 0, second: 0).description, "23:00:00")
    }

    // MARK: Codable

    private struct Wrapped: Codable {
        let time: NaiveTime
    }

    func testDecodable() {
        let time = try! JSONDecoder().decode(Wrapped.self, from: "{\"time\":\"22:15:10\"}".data(using: .utf8)!)
        XCTAssertEqual(time.time, NaiveTime(hour: 22, minute: 15, second: 10))
    }

    func testEncodable() {
        let data = try! JSONEncoder().encode(Wrapped(time: NaiveTime(hour: 22, minute: 15, second: 10)))
        XCTAssertEqual(String(data: data, encoding: .utf8), "{\"time\":\"22:15:10\"}")
    }
}


// MARK: - NaiveDateTime -

class NaiveDateTimeTest: XCTestCase {
    // MARK: Equatable, Hashable, Comparable

    func testEquatable() {
        XCTAssertEqual(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10)),
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10))
        )

        // Same time

        XCTAssertNotEqual(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10)),
            NaiveDateTime(date: NaiveDate(year: 2017, month: 11, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10))
        )
        XCTAssertNotEqual(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10)),
            NaiveDateTime(date: NaiveDate(year: 2017, month: 11, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10))
        )
        XCTAssertNotEqual(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10)),
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 2), time: NaiveTime(hour: 22, minute: 15, second: 10))
        )

        // Same date

        XCTAssertNotEqual(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 21, minute: 15, second: 10)),
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10))
        )
        XCTAssertNotEqual(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10)),
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 16, second: 10))
        )
        XCTAssertNotEqual(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10)),
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 11))
        )
    }

    func testHashable() {
        XCTAssertEqual(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10)).hashValue,
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10)).hashValue
        )

        // Same time

        XCTAssertNotEqual(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10)).hashValue,
            NaiveDateTime(date: NaiveDate(year: 2017, month: 11, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10)).hashValue
        )
        XCTAssertNotEqual(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10)).hashValue,
            NaiveDateTime(date: NaiveDate(year: 2017, month: 11, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10)).hashValue
        )
        XCTAssertNotEqual(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10)).hashValue,
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 2), time: NaiveTime(hour: 22, minute: 15, second: 10)).hashValue
        )

        // Same date

        XCTAssertNotEqual(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 21, minute: 15, second: 10)).hashValue,
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10)).hashValue
        )
        XCTAssertNotEqual(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10)).hashValue,
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 16, second: 10)).hashValue
        )
        XCTAssertNotEqual(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10)).hashValue,
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 11)).hashValue
        )
    }

    func testComparable() {
        XCTAssertEqual(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10)),
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10))
        )

        // Same time

        XCTAssertLessThan(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10)),
            NaiveDateTime(date: NaiveDate(year: 2017, month: 11, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10))
        )
        XCTAssertLessThan(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10)),
            NaiveDateTime(date: NaiveDate(year: 2017, month: 11, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10))
        )
        XCTAssertLessThan(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10)),
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 2), time: NaiveTime(hour: 22, minute: 15, second: 10))
        )

        // Same date

        XCTAssertLessThan(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 21, minute: 15, second: 10)),
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10))
        )
        XCTAssertLessThan(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10)),
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 16, second: 10))
        )
        XCTAssertLessThan(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 10)),
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 22, minute: 15, second: 11))
        )
    }

    // MARK: LosslessStringConvertible

    func testFromString() {
        XCTAssertNil(NaiveDateTime("2017"))

        XCTAssertNil(NaiveDateTime("2017-10T23:10:15"))
        XCTAssertNil(NaiveDateTime("2017-AT23:10:15"))
        XCTAssertNil(NaiveDateTime("SADT23:10:15"))

        XCTAssertNil(NaiveDateTime("2017-10-01T23:10:AA"))
        XCTAssertNil(NaiveDateTime("2017-10-01TBB"))
        XCTAssertNil(NaiveDateTime("2017-10-01")) // FIXME: add support for this case?

        XCTAssertEqual(
            NaiveDateTime("2017-10-01T23:59:59"),
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 23, minute: 59, second: 59))
        )
        XCTAssertEqual(
            NaiveDateTime("2017-10-1T23:59:59"),
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 23, minute: 59, second: 59))
        )
        XCTAssertEqual(
            NaiveDateTime("2017-10-01T23:59"),
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 23, minute: 59, second: 0))
        )
    }

    func testToString() {
        XCTAssertEqual(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 23, minute: 59, second: 59)).description,
            "2017-10-01T23:59:59"
        )
        XCTAssertEqual(
            NaiveDateTime(date: NaiveDate(year: 2017, month: 10, day: 1), time: NaiveTime(hour: 23, minute: 59, second: 0)).description,
            "2017-10-01T23:59:00"
        )
    }

    // MARK: Codable

    private struct Wrapped: Codable {
        let dateTime: NaiveDateTime
    }

    func testDecodable() {
        let dateTime = try! JSONDecoder().decode(Wrapped.self, from: "{\"dateTime\":\"2017-02-01T10:09:08\"}".data(using: .utf8)!)
        XCTAssertEqual(
            dateTime.dateTime,
            NaiveDateTime(date: NaiveDate(year: 2017, month: 2, day: 1), time: NaiveTime(hour: 10, minute: 9, second: 8))
        )
    }

    func testEncodable() {
        let dateTime = NaiveDateTime(date: NaiveDate(year: 2017, month: 2, day: 1), time: NaiveTime(hour: 10, minute: 9, second: 8))
        let data = try! JSONEncoder().encode(Wrapped(dateTime: dateTime))
        XCTAssertEqual(String(data: data, encoding: .utf8), "{\"dateTime\":\"2017-02-01T10:09:08\"}")
    }

    // MARK: Date <-> NaiveDateTime

    func testFromDate() {
        let date = ISO8601DateFormatter().date(from: "2017-12-01T12:00:00Z")!
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 3600)!
        XCTAssertEqual(
            calendar.naiveDateTime(from: date),
            NaiveDateTime("2017-12-01T13:00:00")!
        )
    }

    func testToDate() {
        let dateTime = NaiveDateTime(
            date: NaiveDate(year: 2017, month: 10, day: 1),
            time: NaiveTime(hour: 15, minute: 30, second: 0)
        )
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 3600)!

        XCTAssertEqual(
            calendar.date(from: dateTime),
            _date(from: "2017-10-01T15:30:00+0100")
        )
    }

    func testToDateComponents() {
        XCTAssertEqual(
            NaiveDateTime(
                date: NaiveDate(year: 2017, month: 10, day: 1),
                time: NaiveTime(hour: 15, minute: 30, second: 0)
                ).dateComponents,
            DateComponents(
                year: 2017, month: 10, day: 1,
                hour: 15, minute: 30, second: 0
            )
        )
    }
}

// MARK: - Helpers -

/// ISO-8601 formatter "2017-10-01T15:30:00Z"
private func _date(from string: String) -> Date {
    return _iso8601Formatter.date(from: string)!
}

private let _iso8601Formatter = ISO8601DateFormatter()

/// For code organization.
private func test(_ title: String? = nil, _ closure: () -> Void) {
    closure()
}

private func test<T>(_ title: String? = nil, with element: T, _ closure: (T) -> Void) {
    closure(element)
}
