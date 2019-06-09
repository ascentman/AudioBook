//
//  DataSource.swift
//  AudioBook
//
//  Created by user on 4/24/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

let BooksDict: [String: String] = [
    "matthew": "Євангеліє від Матвія",
    "mark": "Євангеліє від Марка",
    "luke": "Євангеліє від Луки",
    "john": "Євангеліє від Івана",
    "acts": "Дії святих апостолів",
    "james": "Соборне послання Якова",
    "peter1": "Перше соборне послання Петра",
    "peter2": "Друге соборне послання Петра",
    "john1": "Перше соборне послання Івана",
    "john2": "Друге соборне послання Івана",
    "john3": "Третє соборне послання Івана",
    "jude": "Соборне послання Юди",
    "romans": "Послання Павла до Римлян",
    "corinthians1": "Перше послання Павла до коринтян",
    "corinthians2": "Друге послання Павла до коринтян",
    "galatians": "Послання Павла до галатів",
    "ephesians": "Послання Павла до ефесян",
    "philippians": "Послання Павла до филип'ян",
    "colossians": "Послання Павла до колосян",
    "thessalonians1": "Перше послання Павла до солунян",
    "thessalonians2": "Друге послання Павла до солунян",
    "timothy1": "Перше послання Павла до Тимофія",
    "timothy2": "Друге послання Павла до Тимофія",
    "titus": "Послання Павла до Тита",
    "philemon": "Послання Павла до Филимона",
    "hebrews": "Послання до євреїв",
    "revelation": "Об'явлення Івана Богослова",

    "genesis": "Буття",
    "exodus": "Вихід",
    "leviticus": "Левит",
    "numbers": "Числа",
    "deuteronomy": "Повторення Закону",
    "joshua": "Книга Ісуса Навина",
    "judges": "Книга Суддів",
    "ruth": "Книга Рут",
    "samuel1": "Перша книга Самуїлова",
    "samuel2": "Друга книга Самуїлова",
    "kings1": "Перша книга царів",
    "kings2": "Друга книга царів",
    "chronicles1": "Перша книга хронік",
    "chronicles2": "Друга книга хронік",
    "ezra": "Книга Ездри",
    "nehemiah": "Книга Неємії",
    "esther": "Книга Естер",
    "job": "Книга Йова",
    "psalms": "Книга Псалмів",
    "proverbs": "Книга приповістей Соломонових",
    "ecclesia": "Книга Еклезіястова",
    "songs": "Пісня над піснями",
    "isaiah": "Книга пророка Ісаї",
    "jeremiah": "Книга пророка Єремії",
    "lamentations": "Плач Єремії",
    "ezekiel": "Книга пророка Єзекіїля",
    "daniel": "Книга пророка Даниїла",
    "hosea": "Книга пророка Осії",
    "joel": "Книга пророка Йоіла",
    "amos": "Книга пророка Амоса",
    "obadiah": "Книга пророка Овдія",
    "jonah": "Книга пророка Йони",
    "micah": "Книга пророка Михея",
    "nahum": "Книга пророка Наума",
    "habakkuk": "Книга пророка Авакума",
    "zephaniah": "Книга пророка Софонії",
    "haggai": "Книга пророка Огія",
    "zechariah": "Книга пророка Захарія",
    "malachi": "Книга пророка Малахії"
]

let ChaptersDict: [String: Int] = [
    "matthew": 28,
    "mark": 16,
    "luke": 24,
    "john": 21,
    "acts": 28,
    "james": 5,
    "peter1": 5,
    "peter2": 3,
    "john1": 5,
    "john2": 1,
    "john3": 1,
    "jude": 1,
    "romans": 16,
    "corinthians1": 16,
    "corinthians2": 13,
    "galatians": 6,
    "ephesians": 6,
    "philippians": 4,
    "colossians": 4,
    "thessalonians1": 5,
    "thessalonians2": 3,
    "timothy1": 6,
    "timothy2": 4,
    "titus": 3,
    "philemon": 1,
    "hebrews": 13,
    "revelation": 22,

    "genesis": 50,
    "exodus": 40,
    "leviticus": 27,
    "numbers": 36,
    "deuteronomy": 34,
    "joshua": 24,
    "judges": 21,
    "ruth": 4,
    "samuel1": 31,
    "samuel2": 24,
    "kings1": 22,
    "kings2": 25,
    "chronicles1": 29,
    "chronicles2": 36,
    "ezra": 10,
    "nehemiah": 13,
    "esther": 10,
    "job": 42,
    "psalms": 150,
    "proverbs": 31,
    "ecclesia": 12,
    "songs": 8,
    "isaiah": 66,
    "jeremiah": 52,
    "lamentations": 5,
    "ezekiel": 48,
    "daniel": 12,
    "hosea": 14,
    "joel": 4,
    "amos": 9,
    "obadiah": 1,
    "jonah": 4,
    "micah": 7,
    "nahum": 3,
    "habakkuk": 3,
    "zephaniah": 3,
    "haggai": 2,
    "zechariah": 14,
    "malachi": 3
]

final class DataSource {

    private let matthew = Book(name: "Євангеліє від Матвія", testament: .new, label: "matthew", chaptersCount: 28)
    private let mark = Book(name: "Євангеліє від Марка", testament: .new, label: "mark", chaptersCount: 16)
    private let luke = Book(name: "Євангеліє від Луки", testament: .new, label: "luke", chaptersCount: 24)
    private let john = Book(name: "Євангеліє від Івана", testament: .new, label: "john", chaptersCount: 21)
    private let acts = Book(name: "Дії святих апостолів", testament: .new, label: "acts", chaptersCount: 28)
    private let james = Book(name: "Соборне послання Якова", testament: .new, label: "james", chaptersCount: 5)
    private let peter1 = Book(name: "Перше соборне послання Петра", testament: .new, label: "peter1", chaptersCount: 5)
    private let peter2 = Book(name: "Друге соборне послання Петра", testament: .new, label: "peter2", chaptersCount: 3)
    private let john1 = Book(name: "Перше соборне послання Івана", testament: .new, label: "john1", chaptersCount: 5)
    private let john2 = Book(name: "Друге соборне послання Івана", testament: .new, label: "john2", chaptersCount: 1)
    private let john3 = Book(name: "Третє соборне послання Івана", testament: .new, label: "john3", chaptersCount: 1)
    private let jude = Book(name: "Соборне послання Юди", testament: .new, label: "jude", chaptersCount: 1)
    private let romans = Book(name: "Послання Павла до Римлян", testament: .new, label: "romans", chaptersCount: 16)
    private let corinthians1 = Book(name: "Перше послання Павла до коринтян", testament: .new, label: "corinthians1", chaptersCount: 16)
    private let corinthians2 = Book(name: "Друге послання Павла до коринтян", testament: .new, label: "corinthians2", chaptersCount: 13)
    private let galatians = Book(name: "Послання Павла до галатів", testament: .new, label: "galatians", chaptersCount: 6)
    private let ephesians = Book(name: "Послання Павла до ефесян", testament: .new, label: "ephesians", chaptersCount: 6)
    private let philippians = Book(name: "Послання Павла до филип'ян", testament: .new, label: "philippians", chaptersCount: 4)
    private let colossians = Book(name: "Послання Павла до колосян", testament: .new, label: "colossians", chaptersCount: 4)
    private let thessalonians1 = Book(name: "Перше послання Павла до солунян", testament: .new, label: "thessalonians1", chaptersCount: 5)
    private let thessalonians2 = Book(name: "Друге послання Павла до солунян", testament: .new, label: "thessalonians2", chaptersCount: 3)
    private let timothy1 = Book(name: "Перше послання Павла до Тимофія", testament: .new, label: "timothy1", chaptersCount: 6)
    private let timothy2 = Book(name: "Друге послання Павла до Тимофія", testament: .new, label: "timothy2", chaptersCount: 4)
    private let titus = Book(name: "Послання Павла до Тита", testament: .new, label: "titus", chaptersCount: 3)
    private let philemon = Book(name: "Послання Павла до Филимона", testament: .new, label: "philemon", chaptersCount: 1)
    private let hebrews = Book(name: "Послання до євреїв", testament: .new, label: "hebrews", chaptersCount: 13)
    private let revelation = Book(name: "Об'явлення Івана Богослова", testament: .new, label: "revelation", chaptersCount: 22)

    private let genesis = Book(name: "Буття", testament: .old, label: "genesis", chaptersCount: 50)
    private let exodus = Book(name: "Вихід", testament: .old, label: "exodus", chaptersCount: 40)
    private let levit = Book(name: "Левит", testament: .old, label: "leviticus", chaptersCount: 27)
    private let numbers = Book(name: "Числа", testament: .old, label: "numbers", chaptersCount: 36)
    private let deuteronomy = Book(name: "Повторення Закону", testament: .old, label: "deuteronomy", chaptersCount: 34)
    private let joshua = Book(name: "Книга Ісуса Навина", testament: .old, label: "joshua", chaptersCount: 24)
    private let judges = Book(name: "Книга Суддів", testament: .old, label: "judges", chaptersCount: 21)
    private let ruth = Book(name: "Книга Рут", testament: .old, label: "ruth", chaptersCount: 4)
    private let samuel1 = Book(name: "Перша книга Самуїлова", testament: .old, label: "samuel1", chaptersCount: 31)
    private let samuel2 = Book(name: "Друга книга Самуїлова", testament: .old, label: "samuel2", chaptersCount: 24)
    private let kings1 = Book(name: "Перша книга царів", testament: .old, label: "kings1", chaptersCount: 22)
    private let kings2 = Book(name: "Друга книга царів", testament: .old, label: "kings2", chaptersCount: 25)
    private let chronicles1 = Book(name: "Перша книга хронік", testament: .old, label: "chronicles1", chaptersCount: 29)
    private let chronicles2 = Book(name: "Друга книга хронік", testament: .old, label: "chronicles2", chaptersCount: 36)
    private let ezra = Book(name: "Книга Ездри", testament: .old, label: "ezra", chaptersCount: 10)
    private let nehemiah = Book(name: "Книга Неємії", testament: .old, label: "nehemiah", chaptersCount: 13)
    private let esther = Book(name: "Книга Естер", testament: .old, label: "esther", chaptersCount: 10)
    private let job = Book(name: "Книга Йова", testament: .old, label: "job", chaptersCount: 42)
    private let psalms = Book(name: "Книга Псалмів", testament: .old, label: "psalms", chaptersCount: 150)
    private let proverbs = Book(name: "Книга приповістей Соломонових", testament: .old, label: "proverbs", chaptersCount: 31)
    private let ecclesia = Book(name: "Книга Еклезіястова", testament: .old, label: "ecclesia", chaptersCount: 12)
    private let songs = Book(name: "Пісня над піснями", testament: .old, label: "songs", chaptersCount: 8)
    private let isaiah = Book(name: "Книга пророка Ісаї", testament: .old, label: "isaiah", chaptersCount: 66)
    private let jeremiah = Book(name: "Книга пророка Єремії", testament: .old, label: "jeremiah", chaptersCount: 52)
    private let lamentations = Book(name: "Плач Єремії", testament: .old, label: "lamentations", chaptersCount: 5)
    private let ezekiel = Book(name: "Книга пророка Єзекіїля", testament: .old, label: "ezekiel", chaptersCount: 48)
    private let daniel = Book(name: "Книга пророка Даниїла", testament: .old, label: "daniel", chaptersCount: 12)
    private let hosea = Book(name: "Книга пророка Осії", testament: .old, label: "hosea", chaptersCount: 14)
    private let joel = Book(name: "Книга пророка Йоіла", testament: .old, label: "joel", chaptersCount: 4)
    private let amos = Book(name: "Книга пророка Амоса", testament: .old, label: "amos", chaptersCount: 9)
    private let obadiah = Book(name: "Книга пророка Овдія", testament: .old, label: "obadiah", chaptersCount: 1)
    private let jonah = Book(name: "Книга пророка Йони", testament: .old, label: "jonah", chaptersCount: 4)
    private let micah = Book(name: "Книга пророка Михея", testament: .old, label: "micah", chaptersCount: 7)
    private let nahum = Book(name: "Книга пророка Наума", testament: .old, label: "nahum", chaptersCount: 3)
    private let habakkuk = Book(name: "Книга пророка Авакума", testament: .old, label: "habakkuk", chaptersCount: 3)
    private let zephaniah = Book(name: "Книга пророка Софонії", testament: .old, label: "zephaniah", chaptersCount: 3)
    private let haggai = Book(name: "Книга пророка Огія", testament: .old, label: "haggai", chaptersCount: 2)
    private let zechariah = Book(name: "Книга пророка Захарія", testament: .old, label: "zechariah", chaptersCount: 14)
    private let malachi = Book(name: "Книга пророка Малахії", testament: .old, label: "malachi", chaptersCount: 3)

    var newTestament: [Book] = []
    var oldTestament: [Book] = []

    init() {
        newTestament = [
            matthew,
            mark,
            luke,
            john,
            acts,
            romans,
            corinthians1,
            corinthians2,
            galatians,
            ephesians,
            philippians,
            colossians,
            thessalonians1,
            thessalonians2,
            timothy1,
            timothy2,
            titus,
            philemon,
            hebrews,
            james,
            peter1,
            peter2,
            john1,
            john2,
            john3,
            jude,
            revelation
        ]
        oldTestament = [
            genesis,
            exodus,
            levit,
            numbers,
            deuteronomy,
            joshua,
            judges,
            ruth,
            samuel1,
            samuel2,
            kings1,
            kings2,
            chronicles1,
            chronicles2,
            ezra,
            nehemiah,
            esther,
            job,
            psalms,
            proverbs,
            ecclesia,
            songs,
            isaiah,
            jeremiah,
            lamentations,
            ezekiel,
            daniel,
            hosea,
            joel,
            amos,
            obadiah,
            jonah,
            micah,
            nahum,
            habakkuk,
            zephaniah,
            haggai,
            zechariah,
            malachi,
        ]
    }
}
