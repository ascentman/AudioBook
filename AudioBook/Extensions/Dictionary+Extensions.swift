//
//  Dictionary+Extensions.swift
//  AudioBook
//
//  Created by user on 5/29/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

extension Dictionary where Value: Equatable {
    func someKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}
