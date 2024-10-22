//
//  APIGatewayV2+Utils.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 12/29/23.
//

import AWSLambdaEvents
import Foundation
import HTTPTypes

// MARK: - Helpers

fileprivate extension String {
    func quoted() -> String {
        "\"\(self)\""
    }
}

fileprivate extension Array<String> {
    mutating func appendJSON(key: String, value: String) {
        append("\(key.quoted()): \(value)")
    }

    func jsonString() -> String {
        "[\(self.map { $0.quoted() }.joined(separator: ", "))]"
    }
}

fileprivate extension Dictionary<String, String> {
    func jsonString(serializationOptions options: JSONSerialization.WritingOptions = []) throws -> String {
        String(
            decoding: try JSONSerialization.data(withJSONObject: self, options: options),
            as: UTF8.self)
    }
}

// MARK: - Request

public extension APIGatewayV2Request {
    /// Returns a mock request with the given values.
    ///
    /// - Parameters:
    ///   - bodyValue: The value to be used as the request body.
    ///   - encoder: The encoder used to encode the `bodyValue`.
    ///   - method: The HTTP method.
    ///   - rawPath: The raw path.
    ///   - cookies: The cookies.
    ///   - headers: The headers.
    ///   - parameters: The parameters.
    ///   - pathParameters: The path parameters.
    ///   - isBase64Encoded: Whether the body uses Base64 encoding.
    /// - Returns: The mock request.
    static func mock<T: Encodable>(
        _ bodyValue: T,
        encodedWith encoder: JSONEncoder = .init(),
        method: HTTPRequest.Method = .post,
        rawPath: String = "/endpoint",
        cookies: [String]? = nil,
        headers: [String: String] = [:],
        parameters: [String: String]? = nil,
        pathParameters: [String: String]? = nil,
        isBase64Encoded: Bool = false
    ) throws -> Self {
        try mock(
            method: method,
            rawPath: rawPath,
            cookies: cookies,
            headers: headers,
            parameters: parameters,
            pathParameters: pathParameters,
            body: try JSONSerialization.escapedString(
                with: try encoder.encode(bodyValue))
            )
    }

    /// Returns a mock request with the given values.
    ///
    /// - Parameters:
    ///   - method: The HTTP method.
    ///   - rawPath: The raw path.
    ///   - cookies: The cookies.
    ///   - headers: The headers.
    ///   - parameters: The parameters.
    ///   - pathParameters: The path parameters.
    ///   - isBase64Encoded: Whether the body uses Base64 encoding.
    ///   - body: The body.
    /// - Returns: The mock request.
    static func mock(
        // swiftlint:disable:previous function_body_length
        method: HTTPRequest.Method = .post,
        rawPath: String = "/endpoint",
        cookies: [String]? = nil,
        headers: [String: String] = [:],
        parameters: [String: String]? = nil,
        pathParameters: [String: String]? = nil,
        isBase64Encoded: Bool = false,
        body: String? = nil
    ) throws -> Self {
        var rawQueryString = "".quoted()
        var elements: [String] = []
        if let cookies {
            elements.appendJSON(key: "cookies", value: cookies.jsonString())
        }
        elements.appendJSON(key: "headers", value: try headers.jsonString())

        if let parameters {
            elements.appendJSON(key: "queryStringParameters", value: try parameters.jsonString())
            rawQueryString = parameters
                .compactMap { key, value in
                    "\(key)=\(value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? value)"
                }
                .joined(separator: "&")
                .quoted()
        }
        elements.appendJSON(key: "rawQueryString", value: rawQueryString)

        if let pathParameters {
            elements.appendJSON(key: "pathParameters", value: try pathParameters.jsonString())
        }

        if var body {
            if isBase64Encoded {
                body = Data(body.utf8).base64EncodedString()
            }
            elements.appendJSON(key: "body", value: body)
        }

        let additionalJSON = elements.map { "  \($0)" }
            .joined(separator: ",\n")

        // https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-lambda.html
        let jsonString = """
            {
              "version": "2.0",
              "routeKey": "$default",
              "rawPath": "\(rawPath)",
            \(additionalJSON),
              "requestContext": {
                "accountId": "123456789012",
                "apiId": "api-id",
                "authentication": {
                  "clientCert": {
                    "clientCertPem": "CERT_CONTENT",
                    "subjectDN": "www.example.com",
                    "issuerDN": "Example issuer",
                    "serialNumber": "a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1",
                    "validity": {
                      "notBefore": "May 28 12:30:02 2019 GMT",
                      "notAfter": "Aug  5 09:36:04 2021 GMT"
                    }
                  }
                },
                "authorizer": {
                  "jwt": {
                    "claims": {
                      "claim1": "value1",
                      "claim2": "value2"
                    },
                    "scopes": [
                      "scope1",
                      "scope2"
                    ]
                  }
                },
                "domainName": "id.execute-api.us-east-1.amazonaws.com",
                "domainPrefix": "id",
                "http": {
                  "method": "\(method.rawValue)",
                  "path": "/path/to/resource",
                  "protocol": "HTTP/1.1",
                  "sourceIp": "192.168.0.1/32",
                  "userAgent": "agent"
                },
                "requestId": "id",
                "routeKey": "$default",
                "stage": "$default",
                "time": "12/Mar/2020:19:03:58 +0000",
                "timeEpoch": 1583348638390
              },
              "isBase64Encoded": \(isBase64Encoded),
              "stageVariables": {
                "stageVariable1": "value1",
                "stageVariable2": "value2"
              }
            }
            """

        return try JSONDecoder().decode(
            APIGatewayV2Request.self,
            from: jsonString)
    }
}

// MARK: - Response

public extension APIGatewayV2Response {
    /// Returns a mocked response with the given values.
    /// - Parameters:
    ///   - bodyValue: The value to be used as the request body.
    ///   - encoder: The encoder used to encode the `bodyValue`.
    ///   - statusCode: The status code.
    ///   - headers: The headers.
    ///   - isBase64Encoded: Whether the body uses Base64 encoding.
    ///   - cookies: The cookies.
    /// - Returns: The response.
    static func mock<T: Encodable>(
        _ bodyValue: T,
        encodedWith encoder: JSONEncoder = .init(),
        statusCode: HTTPResponse.Status = .ok,
        headers: [String: String]? = nil,
        isBase64Encoded: Bool = false,
        cookies: [String]? = nil
    ) throws -> Self {
        var body = try JSONSerialization.escapedString(
            with: try encoder.encode(bodyValue))
        if isBase64Encoded {
            body = Data(body.utf8).base64EncodedString()
        }

        return APIGatewayV2Response(
            statusCode: statusCode,
            headers: headers,
            body: body,
            isBase64Encoded: isBase64Encoded,
            cookies: cookies)
    }
}
