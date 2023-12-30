//
//  LambdaCoding.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 12/14/23.
//

import Foundation

/// A class of types that decode lambda events and encode a data type to lambda outputs.
public protocol LambdaCoding<Event, Output, UnderlyingEvent, UnderlyingOutput> {
    /// The lambda event.
    associatedtype Event: Codable, Sendable

    /// The type to which the ``Event`` is decoded.
    associatedtype UnderlyingEvent: Codable, Sendable

    /// The lambda output.
    associatedtype Output: Codable, Sendable

    /// The type from which the ``Output`` is encoded.
    associatedtype UnderlyingOutput: Sendable

    /// Returns an underlying event, decoded from a lambda event.
    ///
    /// - Parameter event: The event to encode.
    /// - Returns: An underlying event.
    func decode(event: Event) throws -> UnderlyingEvent

    /// Encodes the given output to that of a lambda.
    ///
    /// - Parameter output: The output to encode.
    /// - Returns: The lambda output.
    func encode(output: UnderlyingOutput) throws -> Output

    /// Encodes the given error to a lambda output.
    ///
    /// - Parameter error: The error to encode.
    /// - Returns: The lambda output.
    func encode(error: Error) throws -> Output
}
