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
    static let lastListened = "lastListened"
    static let historySaving = "historySaving"
    static let autoPlay = "autoPlay"
}

extension UserDefaults {

    var rewindTime: Float64 {
        get {
            return Float64(UserDefaults.standard.float(forKey: Constants.rewindTime))
        }
    }

    var lastListened: String {
        get {
            return UserDefaults.standard.string(forKey: Constants.lastListened) ?? ""
        }
    }

    var historySaving: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Constants.historySaving)
        }
    }

    var autoPlay: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Constants.autoPlay)
        }
    }

    func isRewindTimePresentInUserDefaults() -> Bool {
        return UserDefaults.standard.object(forKey: Constants.rewindTime) != nil
    }

    func isAutoPlayPresentInUserDefaults() -> Bool {
        return UserDefaults.standard.object(forKey: Constants.autoPlay) != nil
    }

    func updateRewindTime(_ value: Float64) {
        UserDefaults.standard.set(value, forKey: Constants.rewindTime)
    }

    func updateLastListened(_ value: String) {
        UserDefaults.standard.set(value, forKey: Constants.lastListened)
    }

    func updateHistorySaving(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: Constants.historySaving)
    }

    func updateAutoPlay(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: Constants.autoPlay)
    }
}
