//
//  Errors.swift
//  AudioBook
//
//  Created by user on 4/30/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

enum ErrorToThrow : Error {
    case failToCreate
    case failToDelete
    case failToReadFromPlist
    case failWriteToPlist
    case failToGetData
}
