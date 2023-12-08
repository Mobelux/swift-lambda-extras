//
//  HandlerError.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 12/8/23.
//

import Foundation

/// An error that occurs during lambda handler execution.
public enum HandlerError: Error {
    /// The request is missing a body.
    case emptyBody
    /// The lambda context is missing an expected environment variable.
    case envError
    /// A custom error.
    case custom(_ message: String?)
}
