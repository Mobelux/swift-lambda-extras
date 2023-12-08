//
//  MockContext.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 12/8/23.
//

import Foundation
import Logging

/// A mock function context for testing.
public struct MockContext<E: RawRepresentable>: FunctionContext where E.RawValue == String {
    var environmentValueProvider: @Sendable (E) throws -> String

    public var requestID: String
    public var traceID: String
    public var invokedFunctionARN: String
    public var deadline: DispatchWallTime
    public var cognitoIdentity: String?
    public var clientContext: String?
    public var logger: Logger

    public init(
        environmentValueProvider: @escaping @Sendable (E) throws -> String,
        requestID: String,
        traceID: String,
        invokedFunctionARN: String,
        deadline: DispatchWallTime,
        cognitoIdentity: String? = nil,
        clientContext: String? = nil,
        logger: Logger
    ) {
        self.environmentValueProvider = environmentValueProvider
        self.requestID = requestID
        self.traceID = traceID
        self.invokedFunctionARN = invokedFunctionARN
        self.deadline = deadline
        self.cognitoIdentity = cognitoIdentity
        self.clientContext = clientContext
        self.logger = logger
    }

    public func value(for environmentVariable: E) throws -> String {
        try environmentValueProvider(environmentVariable)
    }
}
