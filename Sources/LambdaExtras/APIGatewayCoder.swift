//
//  APIGatewayCoder.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 12/14/23.
//

import AWSLambdaEvents
import AWSLambdaRuntime
import Foundation

/// A coder for APIGateway events.
public struct APIGatewayCoder<E, O>: LambdaCoding where E: Codable, E: Sendable, O: Sendable {
    /// A JSON decoder.
    let decoder: JSONDecoder

    /// A closure returning a response body from the given underlying output.
    let responseBodyProvider: @Sendable (O) -> String?

    /// Creates an instance.
    ///
    /// - Parameters:
    ///   - decoder: A JSON decoder.
    ///   - responseBody: A closure returning a response body from the given output.
    public init(
        decoder: JSONDecoder = .init(),
        responseBody: @escaping @Sendable (O) -> String? = { _ in nil }
    ) {
        self.decoder = decoder
        self.responseBodyProvider = responseBody
    }

    public func decode(event: APIGatewayV2Request) async throws -> E {
        guard let body = event.body else {
            throw HandlerError.emptyBody
        }

        return try decoder.decode(E.self, from: body)
    }

    public func encode(output: O) throws -> APIGatewayV2Response {
        APIGatewayV2Response(
            statusCode: .ok,
            body: responseBodyProvider(output))
    }

    public func encode(error: Error) throws -> APIGatewayV2Response {
        switch error {
        case HandlerError.emptyBody:
            return APIGatewayV2Response(
                statusCode: .badRequest,
                body: errorResponseBody(error.localizedDescription))

        case HandlerError.envError:
            return APIGatewayV2Response(
                statusCode: .internalServerError,
                body: errorResponseBody(error.localizedDescription))

        case HandlerError.custom(let message):
            return APIGatewayV2Response(
                statusCode: .internalServerError,
                body: message.flatMap(errorResponseBody))

        default:
            return APIGatewayV2Response(
                statusCode: .internalServerError,
                body: errorResponseBody(error.localizedDescription))
        }
    }
}

private extension APIGatewayCoder {
    /// Returns a response body for the given error.
    ///
    /// - Parameter message: The error message
    /// - Returns: The response body.
    private func errorResponseBody(_ message: String) -> String {
        """
        {"reason": "\(message)"
        """
    }
}
