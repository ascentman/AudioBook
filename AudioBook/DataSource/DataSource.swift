//
//  DataSource.swift
//  AudioBook
//
//  Created by user on 4/24/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

final class DataSource {

    private let matthew = Book(name: "Євангеліє від Матвія", testament: .new, label: "matthew", chaptersCount: 28)
    private let mark = Book(name: "Євангеліє від Марка", testament: .new, label: "mark", chaptersCount: 16)
    private let luke = Book(name: "Євангеліє від Луки", testament: .new, label: "luke", chaptersCount: 24)
    private let john = Book(name: "Євангеліє від Івана", testament: .new, label: "john", chaptersCount: 21)

    private let genesis = Book(name: "Буття", testament: .old, label: "Genesis", chaptersCount: 50)
    private let exodus = Book(name: "Вихід", testament: .old, label: "Exodus", chaptersCount: 48)
    private let levit = Book(name: "Левит", testament: .old, label: "Levit", chaptersCount: 26)
    private let numbers = Book(name: "Числа", testament: .old, label: "Numbers", chaptersCount: 30)

    var newTestament: [Book] = []
    var oldTestament: [Book] = []

    init() {
        newTestament =
[matthew, mark, luke, john, matthew, mark, luke, john, mark, luke, john, mark, luke, john, mark, luke]
        oldTestament = [genesis, exodus, levit, numbers]
    }
}
