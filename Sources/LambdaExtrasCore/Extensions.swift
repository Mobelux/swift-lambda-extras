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

public extension JSONSerialization {
    /// Returns an escaped string for the given JSON object data.
    ///
    /// - Parameters:
    ///   - jsonData: The data from which to generate the JSON string.
    ///   - options: Options for creating the JSON data.
    /// - Returns: An escaped string representation of the given object `jsonData`.
    static func escapedString(with jsonData: Data, options: WritingOptions = []) throws -> String {
        let jsonString = String(decoding: jsonData, as: UTF8.self)
        let data = try data(withJSONObject: [jsonString], options: options)
        let encodedString = String(decoding: data, as: UTF8.self)
        return String(encodedString.dropLast().dropFirst())
    }
}

public extension Optional {
    /// Convienence method to `throw` if an optional type has a `nil` value.
    ///
    /// - Parameter error: The error to throw.
    /// - Returns: The unwrapped value.
    func unwrap(or error: @autoclosure () -> LocalizedError) throws -> Wrapped {
        switch self {
        case .some(let wrapped): return wrapped
        case .none: throw error()
        }
    }
}

extension String: @retroactive Error {}
extension String: @retroactive LocalizedError {
    public var errorDescription: String? { self }
    public var failureReason: String? { self }
}
