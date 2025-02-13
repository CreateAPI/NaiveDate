import Foundation
import NaiveDate
import Testing

@Suite
struct NaiveDateFormatterTest {
    @Test
    func testNaiveTimeFormatter_enUS() {
        let formatter = NaiveDateFormatter {
            $0.locale = Locale(identifier: "en_US")
            $0.timeStyle = .short
        }

        #expect(formatter.string(from: NaiveTime("16:10")!) == "4:10 PM")
        #expect(formatter.string(from: NaiveTime("16:10:15")!) == "4:10 PM")
    }

    @Test
    func testNaiveTimeFormatter_enGB() {
        let formatter = NaiveDateFormatter {
            $0.locale = Locale(identifier: "en_GB")
            $0.timeStyle = .short
        }

        #expect(formatter.string(from: NaiveTime("16:10")!) == "16:10")
        #expect(formatter.string(from: NaiveTime("16:10:15")!) == "16:10")
    }
}
