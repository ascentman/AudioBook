//
//  UserDefaults+Settings.swift
//  AudioBook
//
//  Created by user on 5/28/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

private enum Constants {
    static let rewindTime = "rewindTime"
}

extension UserDefaults {

    var rewindTime: Float64 {
        get {
            return Float64(UserDefaults.standard.float(forKey: Constants.rewindTime))
        }
    }

    func isRewindTimePresentInUserDefaults() -> Bool {
        return UserDefaults.standard.object(forKey: Constants.rewindTime) != nil
    }

    func updateRewindTime(_ value: Float64) {
        UserDefaults.standard.set(value, forKey: Constants.rewindTime)
    }
}
