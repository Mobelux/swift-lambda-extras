# Lambda Extras

Swifty helpers for working with AWS Lambda.

## 📱 Requirements

Swift 5.9 toolchain with Swift Package Manager.

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

## ⚙️ Usage

This package is intended to support the creation of lambdas composed of 2 parts:

- a regular target with a handler implementing the core logic without AWS dependencies
- an executable target using that regular one

### Handler

Create a target without AWS dependencies like `AWSLambdaRuntime` or  `AWSLambdaEvents` to implement the the lambda's core logic. Add a type to represent all environment variables that will be used in the lambda:

```swift
public enum Environment: String {
    case multiplier = "MULTIPLIER"
    ...
}
```

as well as a model for the handler's input and optionally its output:

```swift
public struct Multiplicand: Codable {
    public let value: Int

    public init(value: Int) {
        self.value = value
    }
}
```

and a handler to implement the core logic of the lambda:

```swift
public struct MultiplyHandler {
    public init<C>(
        context: C
    ) async throws where C: InitializationContext, C: EnvironmentValueProvider<Environment> {
        // create any dependencies

        context.handleShutdown { eventLoop in
            // shut dependencies down ...
        }
    }

    public func handle<C>(
        _ event: Multiplicand,
        context: C
    ) async throws -> Int where C: RuntimeContext, C: EnvironmentValueProvider<Environment> {
        let multiplier = try context.value(for: .multiplier)
        return event.value * multiplier
    }
}
```

### Lambda

Create an executable target and declare `EnvironmentValueProvider` conformances for `LambdaInitializationContext` and `LambdaContext`:

```swift
extension LambdaInitializationContext: EnvironmentValueProvider {
    public typealias EnvironmentVariable = Environment
}

extension LambdaContext: EnvironmentValueProvider {
    public typealias EnvironmentVariable = Environment
}
```

and implement a `LambdaHandler` with a `LambdaCoding` type like `APIGatewayCoder` that uses the handler created above:

```swift
@main
struct MultiplyLambda: LambdaHandler {
    let coder: APIGatewayCoder<Multiplicand, Int>
    let handler: MultiplyHandler

    init(context: LambdaInitializationContext) async throws {
        self.coder = APIGatewayCoder()
        self.handler = try await MultiplyHandler(context: context)
    }

    func handle(_ event: APIGatewayV2Request, context: LambdaContext) async throws -> APIGatewayV2Response {
        context.logger.info("RECEIVED: \(event)")
        do {
            let subscription = try await coder.decode(event: event)

            let output = try await handler.handle(subscription, context: context)
            context.logger.info("FINISHED: \(output)")

            return try coder.encode(output: output)
        } catch {
            context.logger.error("UNDERLYING ERROR: \(error.localizedDescription)")
            return try coder.encode(error: error)
        }
    }
}
```
