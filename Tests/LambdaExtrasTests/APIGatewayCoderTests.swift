//
//  APIGatewayCoderTests.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 12/28/23.
//

@testable import LambdaExtras
@testable import LambdaExtrasCore
import AWSLambdaEvents
import Foundation
import LambdaMocks
import XCTest

final class APIGatewayCoderTests: XCTestCase {}

// MARK: - Decode Event
extension APIGatewayCoderTests {
    func testDecode() async throws {
        let body = """
            "{\\"int\\":1,\\"string\\":\\"one\\"}"
            """
        let request = try APIGatewayV2Request.mock(body: body)

        let sut = APIGatewayCoder<TestModel, String>()
        let actual = try sut.decode(event: request)

        XCTAssertEqual(actual, Mock.testModel)
    }

    func testDecodeEmptyBodyThrows() throws {
        let sut = APIGatewayCoder<TestModel, String>()
        let request = try APIGatewayV2Request.mock()

        XCTAssertThrows(try sut.decode(event: request), HandlerError.emptyBody)
    }
}

// MARK: - Encode Output
extension APIGatewayCoderTests {
    func testEncodeEventWithDefaultBody() throws {
        let sut = APIGatewayCoder<TestModel, TestModel>()
        let actual = try sut.encode(output: Mock.testModel)

        XCTAssertEqual(actual.statusCode, .ok)
        XCTAssertNil(actual.body)
    }

    func testEncodeEvent() throws {
        let expectedBody = """
            "{\\"int\\":1,\\"string\\":\\"one\\"}"
            """

        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        let sut = APIGatewayCoder<TestModel, TestModel>(
            responseBody: { model in
                try JSONSerialization.escapedString(with: encoder.encode(model))
            }
        )
        let actual = try sut.encode(output: Mock.testModel)

        XCTAssertEqual(actual.statusCode, .ok)
        XCTAssertEqual(actual.body, expectedBody)
    }
}

// MARK: - Encode Error
extension APIGatewayCoderTests {
    func testEncodeEmptyBodyError() throws {
        let expectedStatus: HTTPResponseStatus = .badRequest
        let expectedBody = "The AWS event did not contain a body."

        let sut = APIGatewayCoder<TestModel, String>()
        let actual = try sut.encode(error: HandlerError.emptyBody)

        XCTAssertEqual(actual.statusCode, expectedStatus)
        XCTAssertEqual(actual.body, expectedBody)
    }

    func testEncodeEnvironmentError() throws {
        let variableName = "MY_ENV_VARIABLE"

        let expectedStatus = HTTPResponseStatus.internalServerError
        let expectedBody = "The environment does not contain the expected variable `\(variableName)`."

        let sut = APIGatewayCoder<TestModel, String>()
        let actual = try sut.encode(error: HandlerError.envError(variableName))

        XCTAssertEqual(actual.statusCode, expectedStatus)
        XCTAssertEqual(actual.body, expectedBody)
    }

    func testEncodeCustomError() throws {
        let expectedStatus = HTTPResponseStatus.internalServerError
        let expectedBody = "My error message"

        let sut = APIGatewayCoder<TestModel, String>()
        let actual = try sut.encode(error: HandlerError.custom(expectedBody))

        XCTAssertEqual(actual.statusCode, expectedStatus)
        XCTAssertEqual(actual.body, expectedBody)
    }

    func testEncodeError() throws {
        struct TestError: LocalizedError {
            var errorDescription: String? { "Oops, something went wrong" }
        }

        let expectedStatus = HTTPResponseStatus.internalServerError
        let expectedBody = "Oops, something went wrong"

        let sut = APIGatewayCoder<TestModel, String>()
        let actual = try sut.encode(error: TestError())

        XCTAssertEqual(actual.statusCode, expectedStatus)
        XCTAssertEqual(actual.body, expectedBody)
    }

    func testEncodeCustomizedError() throws {
        let expectedStatus = HTTPResponseStatus.internalServerError
        let expectedBody = """
            "{\\"reason\\":\\"Oops, something went wrong\\"}"
            """

        let sut = APIGatewayCoder<TestModel, String>(
            errorBody: { error in
                """
                "{\\"reason\\":\\"\(error.localizedDescription)\\"}"
                """
            })
        let actual = try sut.encode(error: HandlerError.custom("Oops, something went wrong"))

        XCTAssertEqual(actual.statusCode, expectedStatus)
        XCTAssertEqual(actual.body, expectedBody)
    }
}
