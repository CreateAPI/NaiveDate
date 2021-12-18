
# NaiveDate 1.x

## NaiveDate 1.0

*Dec 18, 2021*

- Bump minimum required versions
- Remove CocoaPods and Carthage support

# NaiveDate 0.x

## NaiveDate 0.4

- Add Swift 5.0 support
- Add SwiftPM 5.0 support
- Remove Swift 4.0 and Swift 4.1 support
- Add a single `NaiveDate` target which can build the framework for any platform

## NaiveDate 0.3

- `Date` conversion now supports optional timezone parameters

## NaiveDate 0.2.1

- Improve Hashing implementation (reduce number of collisions)
- Use [tuple comparison operators](https://github.com/apple/swift-evolution/blob/master/proposals/0015-tuple-comparison-operators.md) to simplify Comparable implementation

## NaiveDate 0.2

- Get rid of time zones in `NaiveDate`, `NaiveTime`, `NaiveDateTime` APIs
- Add convenience initializer for `NaiveDateTime` with individual date components

## NaiveDate 0.1

Initial release which implements `NaiveDate`, `NaiveTime`, `NaiveDateTime` types, as well as two naive date formatters.
