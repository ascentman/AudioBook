//
//  Book.swift
//  AudioBook
//
//  Created by user on 4/30/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

enum Testament {
    case new
    case old
}

final class Book {

    let name: String
    let testament: Testament
    let label: String
    let chaptersCount: Int
    var bookUrl: String {
        get {
            return baseUrl + label
        }
    }

    private let baseUrl = "https://www.audiobible.inf.ua/bible/"

    init(name: String, testament: Testament, label: String, chaptersCount: Int) {
        self.name = name
        self.testament = testament
        self.label = label
        self.chaptersCount = chaptersCount
    }

    convenience init() {
        let name = ""
        let testament = Testament.new
        let label = ""
        let chaptersCount = 0
        self.init(name: name, testament: testament, label: label, chaptersCount: chaptersCount)
    }
}
