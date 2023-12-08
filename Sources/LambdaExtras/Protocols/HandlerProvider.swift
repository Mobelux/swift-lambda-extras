//
//  HandlerProvider.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 12/8/23.
//

import AWSLambdaEvents
import AWSLambdaRuntime
import Foundation

/// A class of types that provide an `EventHandler` to implement the core logic of a `SimpleLambdaHandler`
/// and translate its input and output to those of a particular AWS Lambda.
public protocol HandlerProvider<Event, Output>: SimpleLambdaHandler {
    /// The event handler responsible for implementing the provider's logic.
    associatedtype Underlying: EventHandler

    /// Returns the event handler responsible for implementing the function's core logic.
    ///
    /// - Parameter context: The Lambda runtime context.
    /// - Returns: The underlying event handler.
    func makeHandler(for context: LambdaContext) throws -> Underlying

    /// Decodes a Lambda event to one accepted by the underlying event handler.
    ///
    /// - Parameter event: The Lambda event to handle.
    /// - Returns: The decoded event for the underlying handler.
    func decode(event: Event) throws -> Underlying.Event

    /// Encodes the underlying handler's output to that of the Lambda.
    ///
    /// - Parameter output: The output of the underlying event handler.
    /// - Returns: The encoded output for the Lambda.
    func encode(output: Underlying.Output) throws -> Output

    /// Encodes an error to the Lambda output.
    /// - Parameter error: The error to encode.
    /// - Returns: The encoded output for the Lambda.
    func handle(error: Error) throws -> Output
}

// MARK: - HandlerProvider+APIGateway

public extension HandlerProvider where Event == APIGatewayV2Request, Output == APIGatewayV2Response {
    func decode(event: APIGatewayV2Request) throws -> Underlying.Event {
        guard let body = event.body else {
            throw HandlerError.emptyBody
        }

        return try JSONDecoder().decode(Underlying.Event.self, from: body)
    }

    func encode(output: Underlying.Output) -> APIGatewayV2Response {
        APIGatewayV2Response(statusCode: .ok)
    }

    func handle(_ event: APIGatewayV2Request, context: LambdaContext) async throws -> APIGatewayV2Response {
        context.logger.info("RECEIVED: \(event)")

        do {
            let underlyingEvent = try decode(event: event)
            let handler = try makeHandler(for: context)
            let output = try await handler.handle(underlyingEvent)
            context.logger.info("FINISHED: \(output)")

            return try encode(output: output)
        } catch {
            return try handle(error: error)
        }
    }

    func handle(error: Error) throws -> APIGatewayV2Response {
        throw error
    }
}
