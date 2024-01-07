//
//  Mocked.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 1/7/24.
//

import Foundation

/// Returns a closure that returns `Void` when invoked.
///
/// - Returns: A closure that returns `Void` when invoked.
public func mocked() -> @Sendable () -> Void {
    { }
}

/// Returns a closure that returns the given value when invoked.
///
/// - Parameter result: The value to return.
/// - Returns: A closure that returns a given value when invoked.
public func mocked<Result: Sendable>(
    _ result: Result
) -> @Sendable () -> Result {
    { result }
}

/// Returns a closure that returns `Void` when invoked.
///
/// - Returns: A closure that returns `Void` when invoked.
public func mocked<A>() -> @Sendable (A) -> Void {
    { _ in }
}

/// Returns a closure that returns the given value when invoked.
///
/// - Parameter result: The value to return.
/// - Returns: A closure that returns a given value when invoked.
public func mocked<A, Result: Sendable>(
    _ result: Result
) -> @Sendable (A) -> Result {
    { _ in result }
}

/// Returns a closure that returns `Void` when invoked.
///
/// - Returns: A closure that returns `Void` when invoked.
public func mocked<A, B>() -> @Sendable (A, B) -> Void {
    { _, _ in }
}

/// Returns a closure that returns the given value when invoked.
///
/// - Parameter result: The value to return.
/// - Returns: A closure that returns a given value when invoked.
public func mocked<A, B, Result: Sendable>(
    _ result: Result
) -> @Sendable (A, B) -> Result {
    { _, _ in result }
}

/// Returns a closure that returns the given value when invoked.
///
/// - Parameter result: The value to return.
/// - Returns: A closure that returns a given value when invoked.
public func mocked<A, B, C, Result: Sendable>(
    _ result: Result
) -> @Sendable (A, B, C) -> Result {
    { _, _, _ in result }
}

/// Returns a closure that returns the given value when invoked.
///
/// - Parameter result: The value to return.
/// - Returns: A closure that returns a given value when invoked.
public func mocked<A, B, C, D, Result: Sendable>(
    _ result: Result
) -> @Sendable (A, B, C, D) -> Result {
    { _, _, _, _ in result }
}

/// Returns a closure that returns the given value when invoked.
///
/// - Parameter result: The value to return.
/// - Returns: A closure that returns a given value when invoked.
public func mocked<A, B, C, D, E, Result: Sendable>(
    _ result: Result
) -> @Sendable (A, B, C, D, E) -> Result {
    { _, _, _, _, _ in result }
}

/// Returns a closure that returns the given value when invoked.
///
/// - Parameter result: The value to return.
/// - Returns: A closure that returns a given value when invoked.
public func mocked<A, B, C, D, E, F, Result: Sendable>(
    _ result: Result
) -> @Sendable (A, B, C, D, E, F) -> Result {
    { _, _, _, _, _, _ in result }
}
