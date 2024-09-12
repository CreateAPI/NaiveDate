// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "NaiveDate",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v11),
        .tvOS(.v11),
        .watchOS(.v4)
    ],
    products: [
        .library(name: "NaiveDate", targets: ["NaiveDate"]),
    ],
    targets: [
        .target(name: "NaiveDate", path: "Sources"),
        .testTarget(name: "NaiveDateTests", dependencies: ["NaiveDate"], path: "Tests")
    ]
)
