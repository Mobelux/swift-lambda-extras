//
//  HandlerError.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 12/8/23.
//

import Foundation

/// An error that occurs during lambda handler execution.
public enum HandlerError: Error, LocalizedError {
    /// The request is missing a body.
    case emptyBody
    /// The lambda context is missing an expected environment variable.
    case envError(String)
    /// A custom error.
    case custom(_ message: String?)

    public var errorDescription: String? {
        switch self {
        case .emptyBody:
            return "The AWS event did not contain a body."
        case .envError(let variable):
            return "The environment does not contain the expected variable `\(variable)`."
        case .custom(let message):
            return message
        }
    }
}
