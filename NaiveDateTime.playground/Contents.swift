import UIKit
import NaiveDateTime


/*:
 ## `NaiveDate`

 Calendar date without timezone.
 */

let date = NaiveDate("2017-11-01")!
Calendar.current.date(from: date)


/*:
 ## `NaiveTime`

 Time without timezone.
 */

let time = NaiveTime("15:00")!
Calendar.current.date(from: time)


/*:
 ## `NaiveDateTime`

 Combined date and time without timezone.
 */

let dateTime = NaiveDateTime("2017-11-01T15:30:00")!
Calendar.current.date(from: dateTime)
