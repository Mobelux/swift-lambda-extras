//
//  EnvironmentValueProvider.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 12/14/23.
//

import Foundation

/// A class of types returning values for environment variables.
public protocol EnvironmentValueProvider<EnvironmentVariable>: Sendable {
    /// The associated type representing context's environment variables.
    associatedtype EnvironmentVariable

    /// Returns the value of the given environment variable.
    ///
    /// - Parameter environmentVariable: The environment variable whose value should be returned.
    func value(for environmentVariable: EnvironmentVariable) throws -> String
}
