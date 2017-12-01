// The MIT License (MIT)
//
// Copyright (c) 2017 Alexander Grebenyuk (github.com/kean).

import Foundation


// MARK: - Naive* -> Date -

public extension Calendar {
    /// Returns a date created from the specified naive date in a given time zone.
    /// - parameter timeZone: `nil` by default (uses Calendar time zone).
    public func date(from date: NaiveDate, in timeZone: TimeZone? = nil) -> Date? {
        return self.date(from: DateComponents(self, timeZone: timeZone, date: date))
    }

    /// Returns a date created from the specified naive time in a given time zone.
    /// - parameter timeZone: `nil` by default (uses Calendar time zone).
    public func date(from time: NaiveTime, in timeZone: TimeZone? = nil) -> Date? {
        return self.date(from: DateComponents(self, timeZone: timeZone, time: time))
    }

    /// Returns a date created from the specified naive datetime in a given time zone.
    /// - parameter timeZone: `nil` by default (uses Calendar time zone).
    public func date(from dateTime: NaiveDateTime, in timeZone: TimeZone? = nil) -> Date? {
        return self.date(from: DateComponents(self, timeZone: timeZone, dateTime: dateTime))
    }
}

// MARK: - Date -> Naive* -

public extension Calendar {
    /// Returns naive date from a date, as if in a given time zone.
    /// - parameter timeZone: `nil` by default (uses Calendar time zone).
    public func naiveDate(from date: Date, in timeZone: TimeZone? = nil) -> NaiveDate {
        let components = self.dateComponents(in: timeZone ?? self.timeZone, from: date)
        return NaiveDate(year: components.year!, month: components.month!, day: components.day!)
    }

    /// Returns naive time from a date, as if in a given time zone.
    /// - parameter timeZone: `nil` by default (uses Calendar time zone).
    public func naiveTime(from date: Date, in timeZone: TimeZone? = nil) -> NaiveTime {
        let components = self.dateComponents(in: timeZone ?? self.timeZone, from: date)
        return NaiveTime(hour: components.hour!, minute: components.minute!, second: components.second!)
    }

    /// Returns naive time from a date, as if in a given time zone.
    /// - parameter timeZone: `nil` by default (uses Calendar time zone).
    public func naiveDateTime(from date: Date, in timeZone: TimeZone? = nil) -> NaiveDateTime {
        let components = self.dateComponents(in: timeZone ?? self.timeZone, from: date)
        return NaiveDateTime(
            date: NaiveDate(year: components.year!, month: components.month!, day: components.day!),
            time: NaiveTime(hour: components.hour!, minute: components.minute!, second: components.second!)
        )
    }
}

// MARK: - Naive* -> DateComponents

public extension DateComponents {
    public init(_ calendar: Calendar? = nil, timeZone: TimeZone? = nil, date: NaiveDate) {
        self.init(calendar: calendar, timeZone: timeZone, year: date.year, month: date.month, day: date.day)
    }

    public init(_ calendar: Calendar? = nil, timeZone: TimeZone? = nil, time: NaiveTime) {
        self.init(calendar: calendar, timeZone: timeZone, hour: time.hour, minute: time.minute, second: time.second)
    }

    public init(_ calendar: Calendar? = nil, timeZone: TimeZone? = nil, dateTime: NaiveDateTime) {
        let date = dateTime.date
        let time = dateTime.time
        self.init(calendar: calendar, timeZone: timeZone, year: date.year, month: date.month, day: date.day, hour: time.hour, minute: time.minute, second: time.second)
    }
}
