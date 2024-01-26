//
//  MockInitializationContext.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 12/14/23.
//

import Foundation
import LambdaExtrasCore
import Logging
import NIOCore

/// A mock initialization context for testing.
public class MockInitializationContext<EnvironmentVariable>: InitializationContext, EnvironmentValueProvider, @unchecked Sendable {
    public let logger: Logger
    public let eventLoop: EventLoop
    public let allocator: ByteBufferAllocator

    /// A collection of closures to be called on shutdown.
    public var handlers: [(EventLoop) -> EventLoopFuture<Void>] = []

    /// A closure returning the value of the given environment variable.
    private var environmentValueProvider: @Sendable (EnvironmentVariable) throws -> String

    /// Creates a new instance.
    ///
    /// - Parameters:
    ///   - logger: The logger.
    ///   - eventLoop: The event loop.
    ///   - allocator: The byte buffer allocator.
    ///   - handlers: Closures to be called on shutdown.
    ///   - environmentValueProvider: A closure returning the value of the given environment
    ///   variable.
    public init(
        logger: Logger = .mock,
        eventLoop: EventLoop,
        allocator: ByteBufferAllocator,
        handlers: [(EventLoop) -> EventLoopFuture<Void>] = [],
        environmentValueProvider: @escaping @Sendable (EnvironmentVariable) throws -> String
    ) {
        self.logger = logger
        self.eventLoop = eventLoop
        self.allocator = allocator
        self.environmentValueProvider = environmentValueProvider
        self.handlers = handlers
    }

    public func handleShutdown(_ handler: @escaping (EventLoop) -> EventLoopFuture<Void>) {
        handlers.append(handler)
    }

    public func value(for environmentVariable: EnvironmentVariable) throws -> String {
        try environmentValueProvider(environmentVariable)
    }

    /// Calls the context's shutdown handlers.
    public func shutdown() {
        for handler in handlers.reversed() {
            _ = handler(eventLoop)
        }
    }
}
