// The MIT License (MIT)
//
// Copyright (c) 2017-2019 Alexander Grebenyuk (github.com/kean).

import Foundation


// MARK: - NaiveDate -

/// Calendar date without a timezone.
public struct NaiveDate: Equatable, Hashable, Comparable, LosslessStringConvertible, Codable, _DateComponentsConvertible {
    public let year: Int, month: Int, day: Int

    /// Initializes the naive date with a given date components.
    /// - important: The naive types don't validate input components. For any
    /// precise manipulations with time use native `Date` and `Calendar` types.
    public init(year: Int, month: Int, day: Int) {
        self.year = year; self.month = month; self.day = day
    }

    // MARK: Equatable, Hashable, Comparable

    public var hashValue: Int {
        return year << 10 ^ month << 5 ^ day
    }

    public static func ==(lhs: NaiveDate, rhs: NaiveDate) -> Bool {
        return (lhs.year, lhs.month, lhs.day) == (rhs.year, rhs.month, rhs.day)
    }

    public static func <(lhs: NaiveDate, rhs: NaiveDate) -> Bool {
        return (lhs.year, lhs.month, lhs.day) < (rhs.year, rhs.month, rhs.day)
    }

    // MARK: LosslessStringConvertible

    /// Creates a naive date from a given string (e.g. "2017-12-30").
    public init?(_ string: String) {
        // Not using `ISO8601DateFormatter` because it only works with `Date`
        guard let cmps = _components(from: string, separator: "-"), cmps.count == 3 else { return nil }
        self = NaiveDate(year: cmps[0], month: cmps[1], day: cmps[2])
    }

    /// Returns a string representation of a naive date (e.g. "2017-12-30").
    public var description: String {
        return String(format: "%i-%.2i-%.2i", year, month, day)
    }

    // MARK: Codable

    public init(from decoder: Decoder) throws {
        self = try _decode(from: decoder)
    }

    public func encode(to encoder: Encoder) throws {
        try _encode(self, to: encoder)
    }

    // MARK: _DateComponentsConvertible

    public var dateComponents: DateComponents {
        return DateComponents(year: year, month: month, day: day)
    }
}


// MARK: - NaiveTime -

/// Time without a timezone. Allows for second precision.
public struct NaiveTime: Equatable, Hashable, Comparable, LosslessStringConvertible, Codable, _DateComponentsConvertible {
    public let hour: Int, minute: Int, second: Int

    /// Initializes the naive time with a given date components.
    /// - important: The naive types don't validate input components. For any
    /// precise manipulations with time use native `Date` and `Calendar` types.
    public init(hour: Int = 0, minute: Int = 0, second: Int = 0) {
        self.hour = hour; self.minute = minute; self.second = second
    }

    public var hashValue: Int {
        return hour << 10 ^ minute << 5 ^ second
    }

    /// Initializes a naive time with a given time interval. E.g.
    /// `NaiveTime(timeInterval: 3610)` returns `NaiveTime(hour: 1, second: 10)`.
    public init(timeInterval ti: Int) {
        self = NaiveTime(hour: ti / 3600, minute: (ti / 60) % 60, second: ti % 60)
    }

    /// Returns a total number of seconds. E.g.
    /// `NaiveTime(hour: 1, second: 10).timeInterval` returns `3610`.
    public var timeInterval: Int {
        return hour * 3600 + minute * 60 + second
    }

    // MARK: Equatable, Comparable

    public static func ==(lhs: NaiveTime, rhs: NaiveTime) -> Bool {
        return (lhs.hour, lhs.minute, lhs.second) == (rhs.hour, rhs.minute, rhs.second)
    }

    public static func <(lhs: NaiveTime, rhs: NaiveTime) -> Bool {
        return (lhs.hour, lhs.minute, lhs.second) < (rhs.hour, rhs.minute, rhs.second)
    }

    // MARK: LosslessStringConvertible

    /// Creates a naive time from a given string (e.g. "23:59", or "23:59:59").
    public init?(_ string: String) {
        guard let cmps = _components(from: string, separator: ":"),
            (2...3).contains(cmps.count) else { return nil }
        self.init(hour: cmps[0], minute: cmps[1], second: (cmps.count > 2 ? cmps[2] : 0))
    }

    /// Returns a string representation of a naive time (e.g. "23:59:59").
    public var description: String {
        return String(format: "%.2i:%.2i:%.2i", hour, minute, second)
    }

    // MARK: Codable

    public init(from decoder: Decoder) throws {
        self = try _decode(from: decoder)
    }

    public func encode(to encoder: Encoder) throws {
        try _encode(self, to: encoder)
    }

    // MARK: _DateComponentsConvertible

    public var dateComponents: DateComponents {
        return DateComponents(hour: hour, minute: minute, second: second)
    }
}


// MARK: - NaiveDateTime -

/// Combined date and time without timezone.
public struct NaiveDateTime: Equatable, Hashable, Comparable, LosslessStringConvertible, Codable, _DateComponentsConvertible {
    public let date: NaiveDate
    public let time: NaiveTime

    /// Initializes the naive datetime with a given date components.
    /// - important: The naive types don't validate input components. For any
    /// precise manipulations with time use native `Date` and `Calendar` types.
    public init(date: NaiveDate, time: NaiveTime) {
        self.date = date; self.time = time
    }

    /// Initializes the naive datetime with a given date components.
    /// - important: The naive types don't validate input components. For any
    /// precise manipulations with time use native `Date` and `Calendar` types.
    public init(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) {
        self.date = NaiveDate(year: year, month: month, day: day)
        self.time = NaiveTime(hour: hour, minute: minute, second: second)
    }

    // MARK: Equatable, Hashable, Comparable

    public var hashValue: Int {
        return date.hashValue << 10 ^ time.hashValue
    }

    public static func ==(lhs: NaiveDateTime, rhs: NaiveDateTime) -> Bool {
        return lhs.date == rhs.date && lhs.time == rhs.time
    }

    public static func <(lhs: NaiveDateTime, rhs: NaiveDateTime) -> Bool {
        if lhs.date != rhs.date { return lhs.date < rhs.date }
        return lhs.time < rhs.time
    }

    // MARK: LosslessStringConvertible

    /// Creates a naive datetime from a given string (e.g. "2017-12-30T23:59:59").
    public init?(_ string: String) {
        let components = string.components(separatedBy: "T")
        guard components.count == 2 else { return nil } // must have both date & time
        guard let date = NaiveDate(components[0]), let time = NaiveTime(components[1]) else { return nil }
        self = NaiveDateTime(date: date, time: time)
    }

    /// Returns a string representation of a naive datetime (e.g. "2017-12-30T23:59:59").
    public var description: String {
        return "\(date)T\(time)"
    }

    // MARK: Codable

    public init(from decoder: Decoder) throws {
        self = try _decode(from: decoder)
    }

    public func encode(to encoder: Encoder) throws {
        try _encode(self, to: encoder)
    }

    // MARK: _DateComponentsConvertible

    public var dateComponents: DateComponents {
        return DateComponents(year: date.year, month: date.month, day: date.day, hour: time.hour, minute: time.minute, second: time.second)
    }
}


// MARK: - Calendar Extensions -

public extension Calendar {
    // MARK: Naive* -> Date

    /// Returns a date in calendar's time zone created from the naive date.
    public func date(from date: NaiveDate, in timeZone: TimeZone? = nil) -> Date? {
        return _date(from: date, in: timeZone)
    }

    /// Returns a date in calendar's time zone created from the naive time.
    public func date(from time: NaiveTime, in timeZone: TimeZone? = nil) -> Date? {
        return _date(from: time, in: timeZone)
    }

    /// Returns a date in calendar's time zone created from the naive datetime.
    public func date(from dateTime: NaiveDateTime, in timeZone: TimeZone? = nil) -> Date? {
        return _date(from: dateTime, in: timeZone)
    }

    internal func _date<T: _DateComponentsConvertible>(from value: T, in timeZone: TimeZone? = nil) -> Date? {
        var components = value.dateComponents
        components.timeZone = timeZone
        return self.date(from: components)
    }

    // MARK: Date -> Naive*

    /// Returns naive date from a date, as if in a given time zone. User calendar's time zone.
    /// - parameter timeZone: By default uses calendar's time zone.
    public func naiveDate(from date: Date, in timeZone: TimeZone? = nil) -> NaiveDate {
        let components = self.dateComponents(in: timeZone ?? self.timeZone, from: date)
        return NaiveDate(year: components.year!, month: components.month!, day: components.day!)
    }

    /// Returns naive time from a date, as if in a given time zone. User calendar's time zone.
    /// - parameter timeZone: By default uses calendar's time zone.
    public func naiveTime(from date: Date, in timeZone: TimeZone? = nil) -> NaiveTime {
        let components = self.dateComponents(in: timeZone ?? self.timeZone, from: date)
        return NaiveTime(hour: components.hour!, minute: components.minute!, second: components.second!)
    }

    /// Returns naive time from a date, as if in a given time zone. User calendar's time zone.
    /// - parameter timeZone: By default uses calendar's time zone.
    public func naiveDateTime(from date: Date, in timeZone: TimeZone? = nil) -> NaiveDateTime {
        let components = self.dateComponents(in: timeZone ?? self.timeZone, from: date)
        return NaiveDateTime(
            date: NaiveDate(year: components.year!, month: components.month!, day: components.day!),
            time: NaiveTime(hour: components.hour!, minute: components.minute!, second: components.second!)
        )
    }
}


// MARK: - Private -

/// A type that can be converted to DateComponents (and in turn to Date).
internal protocol _DateComponentsConvertible {
    var dateComponents: DateComponents { get }
}

private func _decode<T: LosslessStringConvertible>(from decoder: Decoder) throws -> T {
    let container = try decoder.singleValueContainer()
    let string = try container.decode(String.self)
    guard let value = T(string) else {
        throw Swift.DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid string format: \(string)")
    }
    return value
}

private func _encode<T: LosslessStringConvertible>(_ value: T, to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(value.description)
}

private func _components(from string: String, separator: String) -> [Int]? {
    let substrings = string.components(separatedBy: separator)
    let components = substrings.flatMap(Int.init)
    return components.count == substrings.count ? components : nil
}
