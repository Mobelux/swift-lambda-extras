//
//  Mock.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 12/29/23.
//

import Foundation

struct TestModel: Codable, Equatable, Sendable {
    var int: Int
    var string: String
}

enum Mock {
    static var testModel: TestModel {
        // swiftlint:disable:next force_try
        try! JSONDecoder().decode(TestModel.self, from: testModelJSON)
    }

    static let testModelJSON = """
        {"int":1,"string":"one"}
        """
}
