//
//  FunctionContext.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 12/8/23.
//

import Foundation

/// A class of types providing information about a function's runtime context.
///
/// This includes information about the runtime context that is common to all serverless functions
/// as well as the environment values available to a specific function.
public protocol FunctionContext<EnvironmentVariable>: RuntimeContext, Sendable {
    /// The associated type representing context's environment variables.
    associatedtype EnvironmentVariable: RawRepresentable<String>

    /// Returns the value of the given environment variable.
    ///
    /// - Parameter environmentVariable: The environment variable whose value should be returned.
    func value(for environmentVariable: EnvironmentVariable) throws -> String
}

public extension FunctionContext {
    /// Returns the value of the given environment variable.
    ///
    /// - Parameter environmentVariable: The environment variable whose value should be returned.
    func value(for environmentVariable: EnvironmentVariable) throws -> String {
        guard let value = ProcessInfo.processInfo.environment[environmentVariable.rawValue] else {
            throw HandlerError.envError
        }

        return value
    }
}
