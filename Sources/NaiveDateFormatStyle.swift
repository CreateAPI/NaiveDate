//
//  FormatStyle.swift
//  NaiveDate
//
//  Created by Lukáš Valenta on 12.09.2024.
//

import Foundation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public extension NaiveDate {
    struct FormatStyle: Foundation.FormatStyle {
        var date: Date.FormatStyle.DateStyle?
        var time: Date.FormatStyle.TimeStyle?
        var locale: Locale
        var calendar: Calendar
        var timeZone: TimeZone
        var capitalizationContext: FormatStyleCapitalizationContext

        public init(date: Date.FormatStyle.DateStyle? = nil,
                    time: Date.FormatStyle.TimeStyle? = nil,
                    locale: Locale = .autoupdatingCurrent,
                    calendar: Calendar = .autoupdatingCurrent,
                    timeZone: TimeZone = .autoupdatingCurrent,
                    capitalizationContext: FormatStyleCapitalizationContext = .unknown) {
            self.date = date
            self.locale = locale
            self.calendar = calendar
            self.timeZone = timeZone
            self.capitalizationContext = capitalizationContext
        }
        
        public func format(_ value: NaiveDate) -> String {
            calendar.date(from: value).map { date in
                let dateStyle = Date.FormatStyle(
                    date: self.date,
                    time: time,
                    locale: locale,
                    calendar: calendar,
                    timeZone: timeZone,
                    capitalizationContext: capitalizationContext
                )

                return date.formatted(dateStyle)
            } ?? ""
        }

        public func locale(_ locale: Locale) -> NaiveDate.FormatStyle {
            .init(
                date: date,
                locale: locale,
                calendar: calendar,
                timeZone: timeZone,
                capitalizationContext: capitalizationContext
            )
        }
    }

    func formatted<F: Foundation.FormatStyle>(_ format: F) -> F.FormatOutput where F.FormatInput == NaiveDate {
        format.format(self)
    }

    func formatted() -> String {
        formatted(FormatStyle())
    }

    func formatted(date: Date.FormatStyle.DateStyle, time: Date.FormatStyle.TimeStyle = .omitted) -> String {
        formatted(FormatStyle(date: date, time: time))
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public extension NaiveTime {
    struct FormatStyle: Foundation.FormatStyle {
        var date: Date.FormatStyle.DateStyle?
        var time: Date.FormatStyle.TimeStyle?
        var locale: Locale
        var calendar: Calendar
        var timeZone: TimeZone
        var capitalizationContext: FormatStyleCapitalizationContext

        public init(date: Date.FormatStyle.DateStyle? = nil,
                    time: Date.FormatStyle.TimeStyle? = nil,
                    locale: Locale = .autoupdatingCurrent,
                    calendar: Calendar = .autoupdatingCurrent,
                    timeZone: TimeZone = .autoupdatingCurrent,
                    capitalizationContext: FormatStyleCapitalizationContext = .unknown) {
            self.date = date
            self.locale = locale
            self.calendar = calendar
            self.timeZone = timeZone
            self.capitalizationContext = capitalizationContext
        }
        
        public func format(_ value: NaiveTime) -> String {
            calendar.date(from: value).map { date in
                let dateStyle = Date.FormatStyle(
                    date: self.date,
                    time: time,
                    locale: locale,
                    calendar: calendar,
                    timeZone: timeZone,
                    capitalizationContext: capitalizationContext
                )

                return date.formatted(dateStyle)
            } ?? ""
        }

        public func locale(_ locale: Locale) -> NaiveDate.FormatStyle {
            .init(
                date: date,
                locale: locale,
                calendar: calendar,
                timeZone: timeZone,
                capitalizationContext: capitalizationContext
            )
        }
    }

    func formatted<F: Foundation.FormatStyle>(_ format: F) -> F.FormatOutput where F.FormatInput == NaiveTime {
        format.format(self)
    }

    func formatted() -> String {
        formatted(FormatStyle())
    }

    func formatted(date: Date.FormatStyle.DateStyle = .omitted, time: Date.FormatStyle.TimeStyle) -> String {
        formatted(FormatStyle(date: date, time: time))
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public extension NaiveDateTime {
    struct FormatStyle: Foundation.FormatStyle {
        var date: Date.FormatStyle.DateStyle?
        var time: Date.FormatStyle.TimeStyle?
        var locale: Locale
        var calendar: Calendar
        var timeZone: TimeZone
        var capitalizationContext: FormatStyleCapitalizationContext

        public init(date: Date.FormatStyle.DateStyle? = nil,
                    time: Date.FormatStyle.TimeStyle? = nil,
                    locale: Locale = .autoupdatingCurrent,
                    calendar: Calendar = .autoupdatingCurrent,
                    timeZone: TimeZone = .autoupdatingCurrent,
                    capitalizationContext: FormatStyleCapitalizationContext = .unknown) {
            self.date = date
            self.time = time
            self.locale = locale
            self.calendar = calendar
            self.timeZone = timeZone
            self.capitalizationContext = capitalizationContext
        }
        
        public func format(_ value: NaiveDateTime) -> String {
            calendar.date(from: value).map { date in
                let dateStyle = Date.FormatStyle(
                    date: self.date,
                    time: time,
                    locale: locale,
                    calendar: calendar,
                    timeZone: timeZone,
                    capitalizationContext: capitalizationContext
                )

                return date.formatted(dateStyle)
            } ?? ""
        }

        public func locale(_ locale: Locale) -> NaiveDate.FormatStyle {
            .init(
                date: date,
                locale: locale,
                calendar: calendar,
                timeZone: timeZone,
                capitalizationContext: capitalizationContext
            )
        }
    }

    func formatted<F: Foundation.FormatStyle>(_ format: F) -> F.FormatOutput where F.FormatInput == NaiveDateTime {
        format.format(self)
    }

    func formatted() -> String {
        formatted(FormatStyle())
    }

    func formatted(date: Date.FormatStyle.DateStyle, time: Date.FormatStyle.TimeStyle) -> String {
        formatted(FormatStyle(date: date, time: time))
    }
}
