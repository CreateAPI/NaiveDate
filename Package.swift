// swift-tools-version:5.3

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
        .target(name: "NaiveDate", path: "Sources", swiftSettings: [
          .unsafeFlags(
              [
                  "-Xfrontend",
                  "-enable-actor-data-race-checks",
                  "-require-explicit-sendable",
                  "-strict-concurrency=complete",
                  "-warn-concurrency",
              ]
          ),
      ]),
        .testTarget(name: "NaiveDateTests", dependencies: ["NaiveDate"], path: "Tests")
    ]
)
