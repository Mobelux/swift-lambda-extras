//
//  Extensions.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 12/15/23.
//

import AWSLambdaRuntime
import AWSLambdaRuntimeCore
import Foundation
import LambdaExtrasCore
import NIOCore

extension Lambda {
    /// Returns the value of the environment variable with the given name.
    ///
    /// This method throws ``EventHandler.envError`` if a value for the given environment variable
    /// name is not found.
    ///
    /// - Parameter name: The name of the environment variable to return.
    /// - Returns: The value of the given environment variable.
    static func env(name: String) throws -> String {
        guard let value = env(name) else {
            throw HandlerError.envError(name)
        }

        return value
    }
}

public extension EnvironmentValueProvider where EnvironmentVariable == String {
    /// Returns the value of the given environment variable.
    ///
    /// - Parameter environmentVariable: The environment variable whose value should be returned.
    func value(for environmentVariable: EnvironmentVariable) throws -> String {
        try Lambda.env(name: environmentVariable)
    }
}

public extension EnvironmentValueProvider where EnvironmentVariable: RawRepresentable<String> {
    /// Returns the value of the given environment variable.
    ///
    /// - Parameter environmentVariable: The environment variable whose value should be returned.
    func value(for environmentVariable: EnvironmentVariable) throws -> String {
        try Lambda.env(name: environmentVariable.rawValue)
    }
}

extension LambdaContext: RuntimeContext {}

extension LambdaInitializationContext: InitializationContext {
    public func handleShutdown(_ handler: @escaping (EventLoop) -> EventLoopFuture<Void>) {
        terminator.register(name: "shutdown", handler: handler)
    }
}
