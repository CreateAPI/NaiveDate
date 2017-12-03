## NaiveDate 0.2.1

- Improve Hashing implementation (reduce number of collisions)
- Use [tuple comparison operators](https://github.com/apple/swift-evolution/blob/master/proposals/0015-tuple-comparison-operators.md) to simplify Comparable implementation

## NaiveDate 0.2

- Get rid of time zones in `NaiveDate`, `NaiveTime`, `NaiveDateTime` APIs
- Add convenience initializer for `NaiveDateTime` with individual date components

## NaiveDate 0.1

Initial release which implements `NaiveDate`, `NaiveTime`, `NaiveDateTime` types, as well as two naive date formatters.
