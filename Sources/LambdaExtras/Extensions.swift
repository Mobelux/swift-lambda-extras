//
//  Extensions.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 12/8/23.
//

import Foundation

public extension Collection {
    /// A Boolean value indicating whether the collection contains elements.
    var isNotEmpty: Bool {
        !isEmpty
    }
}

extension DecodingError.Context {
    var codingPathStringRepresentation: String {
        codingPath
            .map(\.stringValue)
            .joined(separator: ".")
    }
}

public extension DecodingError {
    /// Returns a string with a human readable reason for json decoding failure.
    var userDescription: String {
        switch self {
        case .dataCorrupted(let context):
            return context.debugDescription
        case let .keyNotFound(key, context):
            return "The JSON attribute `\(context.codingPathStringRepresentation).\(key.stringValue)` is missing."
        case let .typeMismatch(type, context):
            return "The JSON attribute `\(context.codingPathStringRepresentation)` was not expected type \(type)."
        case let .valueNotFound(_, context):
            return "The JSON attribute `\(context.codingPathStringRepresentation)` is null."
        @unknown default:
            return localizedDescription
        }
    }
}

public extension JSONDecoder {
    /// Returns a value of the type you specify, decoded from a JSON object.
    ///
    /// - Parameters:
    ///   - type: The type of the value to decode from the supplied JSON object.
    ///   - jsonString: A string containing the JSON object to decode.
    func decode<T: Decodable>(_ type: T.Type, from jsonString: String) throws -> T {
        try decode(type, from: Data(jsonString.utf8))
    }
}
