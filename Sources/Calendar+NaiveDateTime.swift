// The MIT License (MIT)
//
// Copyright (c) 2017 Alexander Grebenyuk (github.com/kean).

import Foundation


// MARK: - Naive* -> Date -

public extension Calendar {
    /// Returns a date created from the specified naive date in a given time zone.
    /// - parameter timeZone: `nil` by default (uses Calendar time zone).
    public func date(from date: NaiveDate, in timeZone: TimeZone? = nil) -> Date? {
        return _date(from: date, in: timeZone)
    }

    /// Returns a date created from the specified naive time in a given time zone.
    /// - parameter timeZone: `nil` by default (uses Calendar time zone).
    public func date(from time: NaiveTime, in timeZone: TimeZone? = nil) -> Date? {
        return _date(from: time, in: timeZone)
    }

    /// Returns a date created from the specified naive datetime in a given time zone.
    /// - parameter timeZone: `nil` by default (uses Calendar time zone).
    public func date(from dateTime: NaiveDateTime, in timeZone: TimeZone? = nil) -> Date? {
        return _date(from: dateTime, in: timeZone)
    }

    internal func _date<T: _DateComponentsConvertible>(from value: T, in timeZone: TimeZone? = nil) -> Date? {
        return self.date(from: value.dateComponents(timeZone: timeZone))
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
