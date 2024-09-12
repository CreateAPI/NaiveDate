import XCTest

#if canImport(SwiftData)
import SwiftData
#endif

import NaiveDate

@available(iOS 17, *)
@Model class ModelWithDates: Codable {
    var date: NaiveDate
    var time: NaiveTime
    var dateTime: NaiveDateTime

    enum CodingKeys: String, CodingKey {
        case date
        case time
        case dateTime
    }

    init(date: NaiveDate, time: NaiveTime, dateTime: NaiveDateTime) {
        self.date = date
        self.time = time
        self.dateTime = dateTime
    }

    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(NaiveDate.self, forKey: .date)
        time = try container.decode(NaiveTime.self, forKey: .time)
        dateTime = try container.decode(NaiveDateTime.self, forKey: .dateTime)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(date, forKey: .date)
        try container.encode(time, forKey: .time)
        try container.encode(dateTime, forKey: .dateTime)
    }
}

@available(iOS 17, *)
class SwiftDataTests : XCTestCase {
    func createModelContainer() throws -> ModelContainer {
        let schema = Schema([ModelWithDates.self])
        return try ModelContainer(
            for: schema,
            configurations: [
                ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
            ]
        )
    }

    var modelContainer: ModelContainer!

    override func setUp() {
        modelContainer = try! createModelContainer()
    }

    @MainActor
    func testSwiftDataCompositeEncodeDecode() throws {

        let data = """
        {
            "dateTime":"2024-02-01T10:09:08",
            "time": "11:12:13",
            "date": "2025-12-24"
        }
        """.data(using: .utf8)!

        let model = try! JSONDecoder().decode(ModelWithDates.self, from: data)

        let expectedDateTime = NaiveDateTime(date: NaiveDate(year: 2024, month: 2, day: 1), time: NaiveTime(hour: 10, minute: 9, second: 8))
        let expectedDate = NaiveDate(year: 2025, month: 12, day: 24)
        let expectedTime = NaiveTime(hour: 11, minute: 12, second: 13)

        XCTAssertEqual(model.dateTime, expectedDateTime)
        XCTAssertEqual(model.date, expectedDate)
        XCTAssertEqual(model.time, expectedTime)

        modelContainer.mainContext.insert(model)

        /// Save to persistent store
        try modelContainer.mainContext.save()

        let exp = expectation(description: "Background task finished")

        /// Ensure we fetch object directly from persistent store and not reusing in-memory one
        /// It is ensured through creating a detached task, which forces non-main actor queue
        /// And so forces a ModelContext to use other thread
        Task.detached {
            /// Background context
            let otherContext = ModelContext(self.modelContainer)

            /// Fetching our model
            var fetchDescriptor = FetchDescriptor<ModelWithDates>()
            fetchDescriptor.fetchLimit = 1
            let fetchedModel = try otherContext.fetch(fetchDescriptor)[0]

            /// Ensuring data persisted and transformed properly
            XCTAssertEqual(fetchedModel.dateTime, expectedDateTime)
            XCTAssertEqual(fetchedModel.date, expectedDate)
            XCTAssertEqual(fetchedModel.time, expectedTime)

            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
    }
}
