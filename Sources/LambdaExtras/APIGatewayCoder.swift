//
//  APIGatewayCoder.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 12/14/23.
//

import AWSLambdaEvents
import AWSLambdaRuntime
import Foundation
import HTTPTypes
import LambdaExtrasCore

/// A coder for APIGateway events.
public struct APIGatewayCoder<E, O>: LambdaCoding, Sendable where E: Codable, E: Sendable, O: Sendable {
    /// A JSON decoder.
    let decoder: JSONDecoder

    /// A closure returning a response body from the given underlying output.
    let responseBodyProvider: @Sendable (O) throws -> String?

    /// A closure returns a response body from the given error.
    let errorBodyProvider: @Sendable (Error) throws -> String?

    /// Creates an instance.
    ///
    /// - Parameters:
    ///   - decoder: A JSON decoder.
    ///   - responseBody: A closure returning a response body from the given output.
    ///   - errorBody: A closure returning a response body for the given error.
    public init(
        decoder: JSONDecoder = .init(),
        responseBody: @escaping @Sendable (O) throws -> String? = { _ in nil },
        errorBody: @escaping @Sendable (Error) throws -> String? = { $0.localizedDescription }
    ) {
        self.decoder = decoder
        self.responseBodyProvider = responseBody
        self.errorBodyProvider = errorBody
    }

    public func decode(event: APIGatewayV2Request) throws -> E {
        guard let body = event.body else {
            throw HandlerError.emptyBody
        }

        return try decoder.decode(E.self, from: body)
    }

    public func encode(output: O) throws -> APIGatewayV2Response {
        APIGatewayV2Response(
            statusCode: .ok,
            body: try responseBodyProvider(output))
    }

    public func encode(error: Error) throws -> APIGatewayV2Response {
        let status: HTTPResponse.Status
        switch error {
        case HandlerError.emptyBody:
            status = .badRequest
        default:
            status = .internalServerError
        }

        return APIGatewayV2Response(
            statusCode: status,
            body: try errorBodyProvider(error.localizedDescription))
    }
}
