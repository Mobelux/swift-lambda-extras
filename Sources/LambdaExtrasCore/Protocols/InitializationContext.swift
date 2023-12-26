//
//  InitializationContext.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 12/10/23.
//

import Foundation
import Logging
import NIOCore

/// A class of types providing information about the runtime initialization context.
public protocol InitializationContext: Sendable {
    /// `Logger` to log with.
    var logger: Logger { get }

    /// The `EventLoop` the lambda is executed on. Use this to schedule work with.
    ///
    /// - note: The `EventLoop` is shared with the lambda runtime engine and should be handled with extra care.
    ///         Most importantly the `EventLoop` must never be blocked.
    var eventLoop: EventLoop { get }

    /// `ByteBufferAllocator` to allocate `ByteBuffer`.
    var allocator: ByteBufferAllocator { get }

    /// Register a closure to be performed on lambda shutdown.
    ///
    /// - Parameter handler: A closure to execute when the lambda shuts down.
    func handleShutdown(_ handler: @escaping (EventLoop) -> EventLoopFuture<Void>)
}
