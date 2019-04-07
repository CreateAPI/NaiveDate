// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "NaiveDate",
    products: [
        .library(name: "NaiveDate", targets: ["NaiveDate"]),
    ],
    targets: [
        .target(name: "NaiveDate", path: "Sources")
    ]
)
