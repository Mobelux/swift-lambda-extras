//
//  RuntimeContext.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 12/8/23.
//

import Foundation
import Logging
import NIOCore
import struct AWSLambdaRuntime.LambdaContext

/// A class of types providing information about the general runtime context.
public protocol RuntimeContext: Sendable {
    /// The request ID, which identifies the request that triggered the function invocation.
    var requestID: String { get }

    /// The AWS X-Ray tracing header.
    var traceID: String { get }

    /// The ARN of the Lambda function, version, or alias that's specified in the invocation.
    var invokedFunctionARN: String { get }

    /// The timestamp that the function times out.
    var deadline: DispatchWallTime { get }

    /// For invocations from the AWS Mobile SDK, data about the Amazon Cognito identity provider.
    var cognitoIdentity: String? { get }

    /// For invocations from the AWS Mobile SDK, data about the client application and device.
    var clientContext: String? { get }

    /// `Logger` to log with.
    var logger: Logger { get }

    /// The `EventLoop` the Lambda is executed on. Use this to schedule work with.
    ///
    /// - note: The `EventLoop` is shared with the Lambda runtime engine and should be handled with extra care.
    ///         Most importantly the `EventLoop` must never be blocked.
    var eventLoop: EventLoop { get }

    /// `ByteBufferAllocator` to allocate `ByteBuffer`.
    var allocator: ByteBufferAllocator { get }
}

extension LambdaContext: RuntimeContext {}
