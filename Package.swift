// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-lambda-extras",
    platforms: [.macOS(.v12)],
    products: [
        .library(name: "LambdaExtras", targets: ["LambdaExtras"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/swift-aws-lambda-events", branch: "main"),
        .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime", branch: "main")
    ],
    targets: [
        .target(
            name: "LambdaExtras",
            dependencies: [
                .product(name: "AWSLambdaRuntime",package: "swift-aws-lambda-runtime"),
                .product(name: "AWSLambdaEvents", package: "swift-aws-lambda-events")
            ]
        ),
        .testTarget(
            name: "LambdaExtrasTests",
            dependencies: [
                "LambdaExtras"
            ]
        ),
    ]
)
