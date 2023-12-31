//
//  Helpers.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 12/29/23.
//

import Foundation
import XCTest

extension XCTest {
    /// Asserts than an expression throws a given error.
    ///
    /// - Parameters:
    ///   - expression: An expression that can throw an error.
    ///   - expectedError: The expected error value.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case
    ///   where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you
    ///   call this function.
    func XCTAssertThrows<T, E: Error & Equatable>(
        _ expression: @autoclosure () throws -> T,
        _ expectedError: E,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertThrowsError(
            try expression(),
            message(),
            file: file,
            line: line
        ) { error in
            if let typedError = error as? E {
                XCTAssertEqual(typedError, expectedError, file: file, line: line)
            } else {
                XCTFail(
                    "The thrown error (\"\(type(of: error))\") was not the expected type (\"\(E.self)\")",
                    file: file,
                    line: line)
            }
        }
    }
}
