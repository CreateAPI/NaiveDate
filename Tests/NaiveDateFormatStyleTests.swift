import Foundation
import XCTest
import NaiveDate

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
final class NaiveDateFormatStyleTest: XCTestCase {
    func testFormattedNaiveDateAgainstDate_withoutParameters() throws {
        let naiveDate = NaiveDate(year: 2024, month: 8, day: 12)
        let foundationDate = try XCTUnwrap(Calendar.current.date(from: naiveDate))
        
        let formattedFoundationDate = foundationDate.formatted()
        let formattedNaiveDate = naiveDate.formatted()

        XCTAssertEqual(formattedNaiveDate, formattedFoundationDate)
    }

    func testFormattedNaiveDateAgainstDate_numeric() throws {
        let naiveDate = NaiveDate(year: 2024, month: 8, day: 12)
        let foundationDate = try XCTUnwrap(Calendar.current.date(from: naiveDate))
        
        let formattedFoundationDate = foundationDate.formatted(date: .numeric, time: .omitted)
        let formattedNaiveDate = naiveDate.formatted(date: .numeric)

        XCTAssertEqual(formattedNaiveDate, formattedFoundationDate)
    }

    func testFormattedNaiveDateTimeAgainstDate_withoutParameters() throws {
        let naiveDate = NaiveDateTime(date: .init(year: 2024, month: 8, day: 12), time: .init(hour: 5, minute: 3, second: 1))
        let foundationDate = try XCTUnwrap(Calendar.current.date(from: naiveDate))
        
        let formattedFoundationDate = foundationDate.formatted()
        let formattedNaiveDate = naiveDate.formatted()

        XCTAssertEqual(formattedNaiveDate, formattedFoundationDate)
    }

    func testFormattedNaiveDateTimeAgainstDate_numeric() throws {
        let naiveDate = NaiveDateTime(date: .init(year: 2024, month: 8, day: 12), time: .init(hour: 5, minute: 3, second: 1))
        let foundationDate = try XCTUnwrap(Calendar.current.date(from: naiveDate))
        
        let formattedFoundationDate = foundationDate.formatted(date: .numeric, time: .standard)
        let formattedNaiveDate = naiveDate.formatted(date: .numeric, time: .standard)

        XCTAssertEqual(formattedNaiveDate, formattedFoundationDate)
    }
}
