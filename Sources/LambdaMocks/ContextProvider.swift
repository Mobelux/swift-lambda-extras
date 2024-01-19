//
//  ContextProvider.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 1/7/24.
//

import Foundation
import Logging
import NIOCore
import NIO

/// A helper to create and manage mock initialization and runtime contexts for testing.
///
/// Example usage:
///
/// ```swift
/// final class MyHandlerTests: XCTestCase {
///     var contextProvider: ContextProvider<MyEnvironment>
///
///     override func setUp() {
///         contextProvider.setUp()
///     }
///
///     override func tearDown() {
///         XCTAssertNoThrow(try contextProvider.shutdown())
///     }
///
///     func testMyHandler() async throws {
///         let sut = try await MyHandler(context: contextProvider.makeInitializationContext())
///         let actual = try await sut.handle(MockEvent(), context: contextProvider.makeContext())
///         ...
///     }
/// }
/// ```
public struct ContextProvider<E> {
    /// The event loop group used to provide the contexts' event loops.
    public private(set) var eventLoopGroup: EventLoopGroup!

    /// The event loop for the contexts.
    public private(set) var eventLoop: EventLoop!

    /// The logger for the contexts.
    public var logger: Logger

    /// A closure returning the value of the given environment variable.
    public var environmentValueProvider: @Sendable (E) throws -> String

    /// Creates an instance.
    ///
    /// - Parameter environmentValueProvider: A closure returning the value of the given
    /// environment variable.
    public init(
        logger: Logger = .mock,
        environmentValueProvider: @escaping @Sendable (E) throws -> String
    ) {
        self.logger = logger
        self.environmentValueProvider = environmentValueProvider
    }

    /// Sets up the event loop used for the provided initialization and runtime contexts.
    ///
    /// Call this in your test class's `setUp()` method:
    ///
    /// ```swift
    /// final class MyHandlerTests: XCTestCase {
    ///     var contextProvider: ContextProvider<MyEnvironment>
    ///     ...
    ///     override func setUp() {
    ///         contextProvider.setUp()
    ///         ...
    ///     }
    /// }
    /// ```
    public mutating func setUp() {
        eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        eventLoop = eventLoopGroup.next()
    }

    /// Shuts the event loop group down.
    ///
    /// Call this in your test class's `.tearDown()` method:
    ///
    /// ```swift
    /// final class MyHandlerTests: XCTestCase {
    ///     var contextProvider: ContextProvider<MyEnvironment>
    ///     ...
    ///     override func tearDown() {
    ///         XCTAssertNoThrow(try contextProvider.shutdown())
    ///         ...
    ///     }
    /// }
    /// ```
    public mutating func shutdown() throws {
        defer {
            eventLoop = nil
            eventLoopGroup = nil
        }
        try eventLoopGroup.syncShutdownGracefully()
    }

    /// Returns the mocked initialization context.
    public func makeInitializationContext() -> MockInitializationContext<E> {
        .init(
            logger: logger,
            eventLoop: eventLoop,
            allocator: .init(),
            environmentValueProvider: environmentValueProvider)
    }

    /// Returns the mocked runtime context.
    ///
    /// - Parameter configuration: The configuration for the mocked runtime context.
    public func makeContext(
        configuration: MockContext<E>.Configuration = .init()
    ) -> MockContext<E> {
        .init(
            eventLoop: eventLoop,
            configuration: configuration,
            environmentValueProvider: environmentValueProvider)
    }
}
