//
//  MockContext.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 12/8/23.
//

import Dispatch
import Foundation
import LambdaExtrasCore
import Logging
import NIOCore

/// A mock function context for testing.
public struct MockContext<E>: RuntimeContext, EnvironmentValueProvider {
    public var requestID: String
    public var traceID: String
    public var invokedFunctionARN: String
    public var deadline: DispatchWallTime
    public var cognitoIdentity: String?
    public var clientContext: String?
    public var logger: Logger
    public var eventLoop: EventLoop
    public var allocator: ByteBufferAllocator

    /// A closure returning a `TimeAmount` from a given `DispatchWallTime`.
    ///
    /// This is used to return the remaining time until the context's ``deadline``.
    public var remainingTimeProvider: @Sendable (DispatchWallTime) -> TimeAmount

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
    ///   - eventLoop: The event loop.
    ///   - allocator: The byte buffer allocator.
    ///   - remainingTimeProvider: A closure returning a `TimeAmount` from a given `DispatchWallTime`.
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
        eventLoop: EventLoop,
        allocator: ByteBufferAllocator,
        remainingTimeProvider: @escaping @Sendable (DispatchWallTime) -> TimeAmount,
        environmentValueProvider: @escaping @Sendable (E) throws -> String
    ) {
        self.requestID = requestID
        self.traceID = traceID
        self.invokedFunctionARN = invokedFunctionARN
        self.deadline = deadline
        self.cognitoIdentity = cognitoIdentity
        self.clientContext = clientContext
        self.logger = logger
        self.eventLoop = eventLoop
        self.allocator = allocator
        self.remainingTimeProvider = remainingTimeProvider
        self.environmentValueProvider = environmentValueProvider
    }

    public func getRemainingTime() -> TimeAmount {
        remainingTimeProvider(deadline)
    }

    public func value(for environmentVariable: E) throws -> String {
        try environmentValueProvider(environmentVariable)
    }
}

public extension MockContext {

    /// Configuration data for ``MockContext``.
    struct Configuration {
        /// The request ID, which identifies the request that triggered the function invocation.
        public var requestID: String

        /// The AWS X-Ray tracing header.
        public var traceID: String

        /// The ARN of the Lambda function, version, or alias that's specified in the invocation.
        public var invokedFunctionARN: String

        /// The time interval before the context's deadline.
        public var timeout: DispatchTimeInterval

        /// For invocations from the AWS Mobile SDK, data about the Amazon Cognito identity provider.
        public var cognitoIdentity: String?

        /// For invocations from the AWS Mobile SDK, data about the client application and device.
        public var clientContext: String?

        /// Creates an instance.
        ///
        /// - Parameters:
        ///   - requestID: The request ID.
        ///   - traceID: The AWS X-Ray tracing header.
        ///   - invokedFunctionARN: The ARN of the Lambda function.
        ///   - timeout: The time interval before the context's deadline.
        ///   - cognitoIdentity: Data about the Amazon Cognito identity provider.
        ///   - clientContext: Data about the client application and device.
        public init(
            requestID: String = "\(DispatchTime.now().uptimeNanoseconds)",
            traceID: String = "Root=\(DispatchTime.now().uptimeNanoseconds);Parent=\(DispatchTime.now().uptimeNanoseconds);Sampled=1",
            invokedFunctionARN: String = "arn:aws:lambda:us-east-1:\(DispatchTime.now().uptimeNanoseconds):function:custom-runtime",
            timeout: DispatchTimeInterval = .seconds(5),
            cognitoIdentity: String? = nil,
            clientContext: String? = nil
        ) {
            self.requestID = requestID
            self.traceID = traceID
            self.invokedFunctionARN = invokedFunctionARN
            self.timeout = timeout
            self.cognitoIdentity = cognitoIdentity
            self.clientContext = clientContext
        }
    }

    /// Returns the time interval between a given point in time and the current time.
    ///
    /// - Parameter deadline: The time with which to compare now.
    /// - Returns: The time interval between the given deadline and now.
    @Sendable
    static func timeAmountUntil(_ deadline: DispatchWallTime) -> TimeAmount {
        .milliseconds(deadline.millisecondsSinceEpoch - DispatchWallTime.now().millisecondsSinceEpoch)
    }

    /// Creates a new instance.
    ///
    /// - Parameters:
    ///   - eventLoop: The event loop.
    ///   - configuration: The context configuration.
    ///   - logger: The logger.
    ///   - allocator: The byte buffer allocator.
    ///   - remainingTimeProvider:
    ///   - environmentValueProvider: A closure returning the value of the given environment
    ///   variable.
    init(
        eventLoop: EventLoop,
        configuration: Configuration = .init(),
        logger: Logger = .mock,
        allocator: ByteBufferAllocator = .init(),
        remainingTimeProvider: @escaping @Sendable (DispatchWallTime) -> TimeAmount = Self.timeAmountUntil,
        environmentValueProvider: @escaping @Sendable (E) throws -> String
    ) {
        self.requestID = configuration.requestID
        self.traceID = configuration.traceID
        self.invokedFunctionARN = configuration.invokedFunctionARN
        self.deadline = .now() + configuration.timeout
        self.cognitoIdentity = configuration.cognitoIdentity
        self.clientContext = configuration.clientContext
        self.logger = logger
        self.eventLoop = eventLoop
        self.allocator = allocator
        self.remainingTimeProvider = remainingTimeProvider
        self.environmentValueProvider = environmentValueProvider
    }
}
