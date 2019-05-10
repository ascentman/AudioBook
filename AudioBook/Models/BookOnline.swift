//
//  BookOnline.swift
//  AudioBook
//
//  Created by user on 5/5/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

class BookOnline {

    let label: String
    let previewURL: URL
    let chaptersCount: Int
    var downloaded = false

    init(label: String, previewURL: URL, chaptersCount: Int) {
        self.label = label
        self.previewURL = previewURL
        self.chaptersCount = chaptersCount
    }
}
