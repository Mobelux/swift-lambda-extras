//
//  MockContext.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 12/8/23.
//

import Dispatch
import Foundation
import Logging

/// A mock function context for testing.
public struct MockContext<E: RawRepresentable>: FunctionContext where E.RawValue == String {
    public var requestID: String
    public var traceID: String
    public var invokedFunctionARN: String
    public var deadline: DispatchWallTime
    public var cognitoIdentity: String?
    public var clientContext: String?
    public var logger: Logger

    /// A closure returning the value of the given environment variable.
    public var environmentValueProvider: @Sendable (E) throws -> String

    /// Creates a new instance.
    ///
    /// - Parameters:
    ///   - requestID: The request ID.
    ///   - traceID: The tracing header.
    ///   - invokedFunctionARN: The ARN of the Lambda function.
    ///   - deadline: The timestamp that the function times out.
    ///   - cognitoIdentity: The Cognito identity provider ID.
    ///   - clientContext: Data about the client application and device.
    ///   - logger: The logger.
    ///   - environmentValueProvider: A closure returning the value of the given environment
    ///   variable.
    public init(
        requestID: String,
        traceID: String,
        invokedFunctionARN: String,
        deadline: DispatchWallTime,
        cognitoIdentity: String? = nil,
        clientContext: String? = nil,
        logger: Logger,
        environmentValueProvider: @escaping @Sendable (E) throws -> String
    ) {
        self.requestID = requestID
        self.traceID = traceID
        self.invokedFunctionARN = invokedFunctionARN
        self.deadline = deadline
        self.cognitoIdentity = cognitoIdentity
        self.clientContext = clientContext
        self.logger = logger
        self.environmentValueProvider = environmentValueProvider
    }

    public func value(for environmentVariable: E) throws -> String {
        try environmentValueProvider(environmentVariable)
    }
}

public extension MockContext {
    /// Creates a new instance.
    ///
    /// - Parameters:
    ///   - timeout: The time interval at which the function will time out.
    ///   - requestID: The request ID.
    ///   - traceID: The tracing header.
    ///   - invokedFunctionARN: The ARN of the Lambda function.
    ///   - environmentValueProvider: A closure returning the value of the given environment
    ///   variable.
    init(
        timeout: DispatchTimeInterval = .seconds(3),
        requestID: String = UUID().uuidString,
        traceID: String = "abc123",
        invokedFunctionARN: String = "aws:arn:",
        environmentValueProvider: @escaping @Sendable (E) throws -> String
    ) {
        self.environmentValueProvider = environmentValueProvider
        self.requestID = requestID
        self.traceID = traceID
        self.invokedFunctionARN = invokedFunctionARN
        self.deadline = .now() + timeout
        self.logger = Logger(
            label: "mock-logger",
            factory: { _ in StreamLogHandler.standardOutput(label: "mock-logger") }
        )
    }
}
