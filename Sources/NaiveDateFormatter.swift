import Foundation

// MARK: - NaiveDateFormatter

/// Formatting without time zones.
public final class NaiveDateFormatter {
    @usableFromInline
    let formatter = DateFormatter()

    @inlinable
    public init(_ closure: (_ formatter: DateFormatter) -> Void) {
        closure(formatter)
    }

    @inlinable
    public convenience init(format: String) {
        self.init {
            $0.dateFormat = format
        }
    }

    @inlinable
    public convenience init(dateStyle: DateFormatter.Style = .none, timeStyle: DateFormatter.Style = .none) {
        self.init {
            $0.dateStyle = dateStyle
            $0.timeStyle = timeStyle
        }
    }

    public func string(from value: NaiveDate) -> String? {
        return formatter.calendar._date(from: value).map { formatter.string(from: $0) }
    }

    @inlinable
    public func string(from value: NaiveTime) -> String? {
        return formatter.calendar._date(from: value).map { formatter.string(from: $0) }
    }

    @inlinable
    public func string(from value: NaiveDateTime) -> String? {
        return formatter.calendar._date(from: value).map { formatter.string(from: $0) }
    }
}

// MARK: - NaiveDateRangeFormatter

/// Formatting without time zones.
public final class NaiveDateRangeFormatter {
    @usableFromInline
    let formatter = DateIntervalFormatter()

    @inlinable
    public init(_ closure: (_ formatter: DateIntervalFormatter) -> Void) {
        closure(formatter)
    }

    @inlinable
    public convenience init(format: String) {
        self.init {
            $0.dateTemplate = format
        }
    }

    @inlinable
    public convenience init(dateStyle: DateIntervalFormatter.Style = .none, timeStyle: DateIntervalFormatter.Style = .none) {
        self.init {
            $0.dateStyle = dateStyle
            $0.timeStyle = timeStyle
        }
    }

    @inlinable
    public func string(from start: NaiveDate, to end: NaiveDate) -> String? {
        return formatter.calendar._dateRange(from: start, to: end).map { formatter.string(from: $0, to: $1) }
    }

    @inlinable
    public func string(from start: NaiveTime, to end: NaiveTime) -> String? {
        return formatter.calendar._dateRange(from: start, to: end).map { formatter.string(from: $0, to: $1) }
    }

    @inlinable
    public func string(from start: NaiveDateTime, to end: NaiveDateTime) -> String? {
        return formatter.calendar._dateRange(from: start, to: end).map { formatter.string(from: $0, to: $1) }
    }
}

// MARK: - Private

extension Calendar {
    @inlinable
    func _dateRange<T: _DateComponentsConvertible>(from start: T, to end: T) -> (Date, Date)? {
        guard let start = _date(from: start), let end = _date(from: end) else { return nil }
        return (start, end)
    }
}
