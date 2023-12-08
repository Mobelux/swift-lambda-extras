//
//  EventHandler.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 12/8/23.
//

import Foundation

/// A class of types that return an ``Output`` for a given ``Event``.
///
/// Use this type to implement the core logic of a serverless function without dependencies on the
/// implementation details of that function's runtime.
public protocol EventHandler {
    /// The handler's input.
    associatedtype Event: Codable, Sendable

    /// The handler's output.
    associatedtype Output: Sendable

    /// Handles the given event and returns its output.
    ///
    /// - Parameter event: The handler's input.
    /// - Returns: The handler's output.
    func handle(_ event: Event) async throws -> Output
}
