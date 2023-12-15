//
//  EnvironmentValueProvider.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 12/14/23.
//

import Foundation
import AWSLambdaRuntimeCore

/// A class of types returning values for environment variables.
public protocol EnvironmentValueProvider<EnvironmentVariable>: Sendable {
    /// The associated type representing context's environment variables.
    associatedtype EnvironmentVariable

    /// Returns the value of the given environment variable.
    ///
    /// - Parameter environmentVariable: The environment variable whose value should be returned.
    func value(for environmentVariable: EnvironmentVariable) throws -> String
}

public extension EnvironmentValueProvider where EnvironmentVariable == String {
    /// Returns the value of the given environment variable.
    ///
    /// - Parameter environmentVariable: The environment variable whose value should be returned.
    func value(for environmentVariable: EnvironmentVariable) throws -> String {
        guard let value = Lambda.env(environmentVariable) else {
            throw HandlerError.envError(environmentVariable)
        }

        return value
    }
}

public extension EnvironmentValueProvider where EnvironmentVariable: RawRepresentable<String> {
    /// Returns the value of the given environment variable.
    ///
    /// - Parameter environmentVariable: The environment variable whose value should be returned.
    func value(for environmentVariable: EnvironmentVariable) throws -> String {
        guard let value = Lambda.env(environmentVariable.rawValue) else {
            throw HandlerError.envError(environmentVariable.rawValue)
        }

        return value
    }
}

/// The default lambda environment.
public enum DefaultEnvironment: String {
    /// The log level of the lambda's logger.
    case logLevel = "LOG_LEVEL"
}
