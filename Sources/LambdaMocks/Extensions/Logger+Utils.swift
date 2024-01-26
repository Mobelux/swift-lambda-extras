//
//  Logger+Utils.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 1/7/24.
//

import Foundation
import Logging

public extension Logger {
    /// A logger for use in ``MockContext`` and ``MockInitializationContext``.
    static let mock = Logger(
        label: "mock-logger",
        factory: { _ in StreamLogHandler.standardOutput(label: "mock-logger") })
}
