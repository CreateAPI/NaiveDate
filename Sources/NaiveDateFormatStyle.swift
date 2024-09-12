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

        /// Creates a format style for a NaiveDate.
        ///
        /// - Parameters:
        ///   - date: The style to use for formatting the date component. Defaults to `nil`.
        ///   - time: The style to use for formatting the time component. Defaults to `nil`.
        ///   - locale: The locale to use for formatting. Defaults to `autoupdatingCurrent`.
        ///   - calendar: The calendar to use for formatting. Defaults to `autoupdatingCurrent`.
        ///   - timeZone: The time zone to use for formatting. Defaults to `autoupdatingCurrent`.
        ///   - capitalizationContext: The context for capitalization. Defaults to `unknown`.
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
        
        /// Formats the given NaiveDate value.
        ///
        /// - Parameter value: The NaiveDate value to format.
        /// - Returns: A formatted string representing the NaiveDate.
        public func format(_ value: NaiveDate) -> String {
            calendar.date(from: value).map { date in
                let dateStyle = Date.FormatStyle(
                    date: self.date,
                    time: self.time,
                    locale: locale,
                    calendar: calendar,
                    timeZone: timeZone,
                    capitalizationContext: capitalizationContext
                )
                return date.formatted(dateStyle)
            } ?? ""
        }

        /// Returns a new format style with the specified locale.
        ///
        /// - Parameter locale: The locale to apply to the format style.
        /// - Returns: A new `NaiveDate.FormatStyle` with the given locale.
        public func locale(_ locale: Locale) -> NaiveDate.FormatStyle {
            .init(
                date: date,
                time: time,
                locale: locale,
                calendar: calendar,
                timeZone: timeZone,
                capitalizationContext: capitalizationContext
            )
        }
    }

    /// Formats the NaiveDate using the provided format style.
    ///
    /// - Parameter format: The format style to apply.
    /// - Returns: The formatted string output.
    func formatted<F: Foundation.FormatStyle>(_ format: F) -> F.FormatOutput where F.FormatInput == NaiveDate {
        format.format(self)
    }

    /// Formats the NaiveDate using the default format style.
    ///
    /// - Returns: A formatted string representation of the NaiveDate.
    func formatted() -> String {
        formatted(FormatStyle())
    }

    /// Formats the NaiveDate with specified date and time styles.
    ///
    /// - Parameters:
    ///   - date: The style to use for formatting the date component.
    ///   - time: The style to use for formatting the time component.
    /// - Returns: A formatted string representation of the NaiveDate.
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

        /// Creates a format style for a NaiveTime.
        ///
        /// - Parameters:
        ///   - dateStyle: The style to use for formatting the date component. Defaults to `nil`.
        ///   - timeStyle: The style to use for formatting the time component. Defaults to `nil`.
        ///   - locale: The locale to use for formatting. Defaults to `autoupdatingCurrent`.
        ///   - calendar: The calendar to use for formatting. Defaults to `autoupdatingCurrent`.
        ///   - timeZone: The time zone to use for formatting. Defaults to `autoupdatingCurrent`.
        ///   - capitalizationContext: The context for capitalization. Defaults to `unknown`.
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
        
        /// Formats the given NaiveTime value.
        ///
        /// - Parameter value: The NaiveTime value to format.
        /// - Returns: A formatted string representing the NaiveTime.
        public func format(_ value: NaiveTime) -> String {
            calendar.date(from: value).map { date in
                let dateStyle = Date.FormatStyle(
                    date: self.date,
                    time: self.time,
                    locale: locale,
                    calendar: calendar,
                    timeZone: timeZone,
                    capitalizationContext: capitalizationContext
                )
                return date.formatted(dateStyle)
            } ?? ""
        }

        /// Returns a new format style with the specified locale.
        ///
        /// - Parameter locale: The locale to apply to the format style.
        /// - Returns: A new `NaiveTime.FormatStyle` with the given locale.
        public func locale(_ locale: Locale) -> NaiveTime.FormatStyle {
            .init(
                date: date,
                time: time,
                locale: locale,
                calendar: calendar,
                timeZone: timeZone,
                capitalizationContext: capitalizationContext
            )
        }
    }

    /// Formats the NaiveTime using the provided format style.
    ///
    /// - Parameter format: The format style to apply.
    /// - Returns: The formatted string output.
    func formatted<F: Foundation.FormatStyle>(_ format: F) -> F.FormatOutput where F.FormatInput == NaiveTime {
        format.format(self)
    }

    /// Formats the NaiveTime using the default format style.
    ///
    /// - Returns: A formatted string representation of the NaiveTime.
    func formatted() -> String {
        formatted(FormatStyle())
    }

    /// Formats the NaiveTime with specified date and time styles.
    ///
    /// - Parameters:
    ///   - date: The style to use for formatting the date component.
    ///   - time: The style to use for formatting the time component.
    /// - Returns: A formatted string representation of the NaiveTime.
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

        /// Creates a format style for a NaiveDateTime.
        ///
        /// - Parameters:
        ///   - dateStyle: The style to use for formatting the date component. Defaults to `nil`.
        ///   - timeStyle: The style to use for formatting the time component. Defaults to `nil`.
        ///   - locale: The locale to use for formatting. Defaults to `autoupdatingCurrent`.
        ///   - calendar: The calendar to use for formatting. Defaults to `autoupdatingCurrent`.
        ///   - timeZone: The time zone to use for formatting. Defaults to `autoupdatingCurrent`.
        ///   - capitalizationContext: The context for capitalization. Defaults to `unknown`.
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

        /// Formats the given NaiveDateTime value.
        ///
        /// - Parameter value: The NaiveDateTime value to format.
        /// - Returns: A formatted string representing the NaiveDateTime.
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

        /// Returns a new format style with the specified locale.
        ///
        /// - Parameter locale: The locale to apply to the format style.
        /// - Returns: A new `NaiveDateTime.FormatStyle` with the given locale.
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

    /// Formats the NaiveDateTime using the provided format style.
    ///
    /// - Parameter format: The format style to apply.
    /// - Returns: The formatted string output.
    func formatted<F: Foundation.FormatStyle>(_ format: F) -> F.FormatOutput where F.FormatInput == NaiveDateTime {
        format.format(self)
    }

    /// Formats the NaiveDateTime using the default format style.
    ///
    /// - Returns: A formatted string representation of the NaiveDateTime.
    func formatted() -> String {
        formatted(FormatStyle())
    }

    /// Formats the NaiveDateTime with specified date and time styles.
    ///
    /// - Parameters:
    ///   - date: The style to use for formatting the date component.
    ///   - time: The style to use for formatting the time component.
    /// - Returns: A formatted string representation of the NaiveDateTime.
    func formatted(date: Date.FormatStyle.DateStyle, time: Date.FormatStyle.TimeStyle) -> String {
        formatted(FormatStyle(date: date, time: time))
    }
}
