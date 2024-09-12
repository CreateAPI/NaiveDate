// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "NaiveDate",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "NaiveDate", targets: ["NaiveDate"]),
    ],
    targets: [
        .target(name: "NaiveDate", path: "Sources"),
        .testTarget(name: "NaiveDateTests", dependencies: ["NaiveDate"], path: "Tests")
    ]
)
