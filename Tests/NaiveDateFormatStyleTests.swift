import Foundation
import Testing
import NaiveDate

@Suite
struct NaiveDateFormatStyleTests {
    @Test
    func formattedNaiveDateAgainstDate_withoutParameters() throws {
        let naiveDate = NaiveDate(year: 2024, month: 8, day: 12)
        let foundationDate = try #require(Calendar.current.date(from: naiveDate))

        let formattedFoundationDate = foundationDate.formatted()
        let formattedNaiveDate = naiveDate.formatted()

        #expect(formattedNaiveDate == formattedFoundationDate)
    }

    @Test
    func formattedNaiveDateAgainstDate_numeric() throws {
        let naiveDate = NaiveDate(year: 2024, month: 8, day: 12)
        let foundationDate = try #require(Calendar.current.date(from: naiveDate))

        let formattedFoundationDate = foundationDate.formatted(date: .numeric, time: .omitted)
        let formattedNaiveDate = naiveDate.formatted(date: .numeric)

        #expect(formattedNaiveDate == formattedFoundationDate)
    }

    @Test
    func formattedNaiveDateTimeAgainstDate_withoutParameters() throws {
        let naiveDate = NaiveDateTime(date: .init(year: 2024, month: 8, day: 12), time: .init(hour: 5, minute: 3, second: 1))
        let foundationDate = try #require(Calendar.current.date(from: naiveDate))

        let formattedFoundationDate = foundationDate.formatted()
        let formattedNaiveDate = naiveDate.formatted()

        #expect(formattedNaiveDate == formattedFoundationDate)
    }

    @Test
    func formattedNaiveDateTimeAgainstDate_numeric() throws {
        let naiveDate = NaiveDateTime(date: .init(year: 2024, month: 8, day: 12), time: .init(hour: 5, minute: 3, second: 1))
        let foundationDate = try #require(Calendar.current.date(from: naiveDate))

        let formattedFoundationDate = foundationDate.formatted(date: .numeric, time: .standard)
        let formattedNaiveDate = naiveDate.formatted(date: .numeric, time: .standard)

        #expect(formattedNaiveDate == formattedFoundationDate)
    }

    @Test
    func localeSet_naiveDateTime() throws {
        let locale = Locale(identifier: "en")
        let formatStyle = NaiveDateTime.FormatStyle(date: .long, time: .shortened)
        let sut = formatStyle.locale(locale)
        let expectedFormatStyle = NaiveDateTime.FormatStyle(date: .long, time: .shortened, locale: locale)

        #expect(sut == expectedFormatStyle)

    }

    @Test
    func localeSet_naiveDate() throws {
        let locale = Locale(identifier: "en")
        let formatStyle = NaiveDate.FormatStyle(date: .long, time: .shortened)
        let sut = formatStyle.locale(locale)
        let expectedFormatStyle = NaiveDate.FormatStyle(date: .long, time: .shortened, locale: locale)

        #expect(sut == expectedFormatStyle)

    }

    @Test
    func localeSet_naiveTime() throws {
        let locale = Locale(identifier: "en")
        let formatStyle = NaiveTime.FormatStyle(date: .long, time: .shortened)
        let sut = formatStyle.locale(locale)
        let expectedFormatStyle = NaiveTime.FormatStyle(date: .long, time: .shortened, locale: locale)

        #expect(sut == expectedFormatStyle)

    }
}

