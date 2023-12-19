// swift-tools-version: 5.7
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
        .package(url: "https://github.com/apple/swift-log.git", .upToNextMajor(from: "1.4.2")),
        .package(url: "https://github.com/apple/swift-nio.git", .upToNextMajor(from: "2.43.1")),
        .package(url: "https://github.com/swift-server/swift-aws-lambda-events.git", branch: "main"),
        .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime.git", branch: "main")
    ],
    targets: [
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
                .product(name: "AWSLambdaRuntime",package: "swift-aws-lambda-runtime"),
                .product(name: "AWSLambdaEvents", package: "swift-aws-lambda-events")
            ]
        ),
        .target(
            name: "LambdaMocks",
            dependencies: [
                "LambdaExtrasCore"
            ]
        ),
        .testTarget(
            name: "LambdaExtrasTests",
            dependencies: [
                "LambdaExtras"
            ]
        )
    ]
)
