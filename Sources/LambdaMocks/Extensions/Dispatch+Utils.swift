//
//  Dispatch+Utils.swift
//  LambdaExtras
//
//  Created by Mathew Gacy on 1/19/24.
//

import Dispatch

extension DispatchWallTime {
    /// The interval between the point and its reference point.
    var millisecondsSinceEpoch: Int64 {
        Int64(bitPattern: self.rawValue) / -1_000_000
    }
}
