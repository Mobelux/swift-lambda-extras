// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-lambda-extras",
    platforms: [.macOS(.v12)],
    products: [
        .library(name: "LambdaExtras", targets: ["LambdaExtras"]),
        // Core library; does not link AWS products.
        .library(name: "LambdaExtrasCore", targets: ["LambdaExtrasCore"]),
        // Testing helpers
        .library(name: "LambdaMocks", targets: ["LambdaMocks"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.4.2"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.43.1"),
        .package(url: "https://github.com/swift-server/swift-aws-lambda-events", from: "0.2.0"),
        .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime", from: "1.0.0-alpha.3")
    ]
)

let targets: [Target] = [
    .target(
        name: "LambdaExtrasCore",
        dependencies: [
            .product(name: "Logging", package: "swift-log"),
            .product(name: "NIOCore", package: "swift-nio")
        ]
    ),
    .target(
        name: "LambdaExtras",
        dependencies: [
            "LambdaExtrasCore",
            .product(name: "AWSLambdaRuntime", package: "swift-aws-lambda-runtime"),
            .product(name: "AWSLambdaEvents", package: "swift-aws-lambda-events")
        ]
    ),
    .target(
        name: "LambdaMocks",
        dependencies: [
            "LambdaExtrasCore",
            .product(name: "AWSLambdaEvents", package: "swift-aws-lambda-events"),
            .product(name: "NIO", package: "swift-nio")
        ]
    ),
    .testTarget(
        name: "LambdaExtrasTests",
        dependencies: [
            "LambdaExtras",
            "LambdaMocks"
        ]
    )
]

for target in targets {
    target.swiftSettings = [.enableExperimentalFeature("StrictConcurrency")]
}

package.targets = targets
