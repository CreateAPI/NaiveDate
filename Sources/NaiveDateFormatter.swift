// The MIT License (MIT)
//
// Copyright (c) 2017 Alexander Grebenyuk (github.com/kean).

import Foundation


// MARK: - NaiveDateFormatter -

/// Formatting without time zones.
public final class NaiveDateFormatter {
    private var formatter = DateFormatter()
    private let converter = NaiveDateTimeConverter()

    public init(locale: Locale = Locale.current, format: String) {
        formatter.locale = locale
        formatter.timeZone = converter.timeZone // important! UTC to UTC
        formatter.dateFormat = format
    }

    public init(locale: Locale = Locale.current, dateStyle: DateFormatter.Style = .none, timeStyle: DateFormatter.Style = .none) {
        formatter.locale = locale
        formatter.timeZone = converter.timeZone // important! UTC to UTC
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
    }

    public func string(from date: NaiveDate) -> String? {
        return converter.date(from: date).map { formatter.string(from: $0) }
    }

    public func string(from time: NaiveTime) -> String? {
        return converter.date(from: time).map { formatter.string(from: $0) }
    }

    public func string(from dateTime: NaiveDateTime) -> String? {
        return converter.date(from: dateTime).map { formatter.string(from: $0) }
    }
}


// MARK: - NaiveDateRangeFormatter -

/// Formatting without time zones.
public final class NaiveDateRangeFormatter {
    private let formatter = DateIntervalFormatter()
    private let converter = NaiveDateTimeConverter()

    public init(locale: Locale = Locale.current, format: String) {
        formatter.locale = locale
        formatter.timeZone = converter.timeZone // important! UTC to UTC
        formatter.dateTemplate = format
    }

    public init(locale: Locale = Locale.current, dateStyle: DateIntervalFormatter.Style = .none, timeStyle: DateIntervalFormatter.Style = .none) {
        formatter.locale = locale
        formatter.timeZone = converter.timeZone // important! UTC to UTC
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
    }

    public func string(from start: NaiveDate, to end: NaiveDate) -> String? {
        return converter.dateRange(from: start, to: end).map { formatter.string(from: $0, to: $1) }
    }

    public func string(from start: NaiveTime, to end: NaiveTime) -> String? {
        return converter.dateRange(from: start, to: end).map { formatter.string(from: $0, to: $1) }
    }

    public func string(from start: NaiveDateTime, to end: NaiveDateTime) -> String? {
        return converter.dateRange(from: start, to: end).map { formatter.string(from: $0, to: $1) }
    }
}


// MARK: - Private -

/// Converts `Naive*` to `Date` in UTC.
private final class NaiveDateTimeConverter {
    private let calendar = Calendar.current
    let timeZone = TimeZone(secondsFromGMT: 0)!

    func date<T: _DateComponentsConvertible>(from date: T) -> Date? {
        return calendar._date(from: date, in: timeZone)
    }

    func dateRange<T: _DateComponentsConvertible>(from start: T, to end: T) -> (Date, Date)? {
        guard let start = date(from: start), let end = date(from: end) else { return nil }
        return (start, end)
    }
}
