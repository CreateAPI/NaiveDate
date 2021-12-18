#  NaiveDate

<p align="left">
<img src="https://img.shields.io/cocoapods/p/NaiveDate.svg?style=flat)">
<img src="https://github.com/kean/Nuke/workflows/NaiveDate%20CI/badge.svg">
</p>

Native `Date` type is great for working with time zones (e.g. `2017-09-29T15:00:00+0300`), but there are scenarios where you don't know or care about the time zone. These types of dates are often called **naive**.


## Usage

The `NaiveDate` library implements three types:

- `NaiveDate` (e.g. `2021-09-29`)
- `NaiveTime` (e.g. `15:30:00`)
- `NaiveDateTime` (e.g. `2021-09-29T15:30:00` - no time zone and no offset).

They all implement `Equatable`, `Comparable`, `LosslessStringConvertible`, and `Codable` protocols. Naive date types can also be converted to `Date`, and `DateComponents`.

### Create

Naive dates and times can be created from a string (using a predefined format – [RFC 3339](https://datatracker.ietf.org/doc/html/rfc3339#section-5.6), using `Decodable`, or with a memberwise initializer:

```swift
NaiveDate("2021-10-01")
NaiveDate(year: 2021, month: 10, day: 1)

NaiveTime("15:30:00")
NaiveTime(hour: 15, minute: 30, second: 0)

NaiveDateTime("2021-10-01T15:30")
NaiveDateTime(
    date: NaiveDate(year: 2021, month: 10, day: 1),
    time: NaiveTime(hour: 15, minute: 30, second: 0)
)
```

### Format

Format dates without having to worry about time zones:

```swift
let date = NaiveDate("2021-11-01")!
NaiveDateFormatter(dateStyle: .short).string(from: date)
// prints "Nov 1, 2021"

let time = NaiveTime("15:00")!
NaiveDateFormatter(timeStyle: .short).string(from: time)
// prints "3:00 PM"

let dateTime = NaiveDateTime("2021-11-01T15:30:00")!
NaiveDateFormatter(dateStyle: .short, timeStyle: .short).string(from: dateTime)
// prints "Nov 1, 2021 at 3:30 PM"
```

### Convert

When you do need to work with time zones, simply convert `NaiveDate` to `Date`:

```swift
let date = NaiveDate(year: 2021, month: 10, day: 1)

// Creates `Date` in a calendar's time zone
// "2021-10-01T00:00:00+0300" if user is in MSK
Calendar.current.date(from: date)
```

```swift
let dateTime = NaiveDateTime(
    date: NaiveDate(year: 2021, month: 10, day: 1),
    time: NaiveTime(hour: 15, minute: 30, second: 0)
)

// Creates `Date` in a calendar's time zone
// "2021-10-01T15:30:00+0300" if user is in MSK
Calendar.current.date(from: dateTime)
```

**Important!** The naive types are called this way because they don’t have a time zone associated with them. This means the date may not actually exist in some areas in the world, even though they are “valid”. For example, when daylight saving changes are applied the clock typically moves forward or backward by one hour. This means certain dates never occur or may occur more than once. If you need to do any precise manipulations with time, always use native `Date` and `Calendar`.

## Requirements

| NaiveDate            | Swift                 | Xcode                | Platforms                                         |
|----------------------|-----------------------|----------------------|---------------------------------------------------|
| NaiveDate 1.0        | Swift 5.3             | Xcode 12.0           | iOS 11.0 / watchOS 4.0 / macOS 10.13 / tvOS 11.0  |
| NaiveDate 0.4        | Swift 4.2 – 5.0       | Xcode 10.1 – 10.2    | iOS 10.0 / watchOS 3.0 / macOS 10.12 / tvOS 10.0  |
| NaiveDate 0.3        | Swift 4.0 – 4.2       | Xcode 9.2 – 10.1     | iOS 10.0 / watchOS 3.0 / macOS 10.12 / tvOS 10.0  |

## License

NaiveDate is available under the MIT license. See the LICENSE file for more info.
