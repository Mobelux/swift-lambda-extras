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

extension LambdaContext: RuntimeContext {}

extension LambdaInitializationContext: InitializationContext {
    public func handleShutdown(_ handler: @escaping (EventLoop) -> EventLoopFuture<Void>) {
        terminator.register(name: "shutdown", handler: handler)
    }
}
