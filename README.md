# Lambda Extras

Swifty helpers for working with AWS Lambda.

## 📱 Requirements

Swift 5.7 toolchain with Swift Package Manager.

## 🖥 Installation

Lambda Extras is distributed using the [Swift Package Manager](https://swift.org/package-manager). To install it into a project, add it as a dependency within your `Package.swift` manifest:

```swift
dependencies: [
    .package(url: "https://github.com/Mobelux/swift-lambda-extras.git", from: "0.1.0")
]
```

Then, add the relevant product to any targets that need access to the library:

```swift
.product(name: "<product>", package: "swift-lambda-extras"),
```

Where `<product>` is one of the following:

- `LambdaExtrasCore`
- `LambdaExtras`
- `LambdaMocks`

