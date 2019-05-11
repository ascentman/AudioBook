//
//  FileHandler.swift
//  AudioBook
//
//  Created by user on 5/5/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

final class FileHandler {

    private let fileManager = FileManager.default

    var documentDirectory : URL? {
        get {
            guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
                return nil
            }
            return documentDirectory
        }
    }

    func localFilePath(for url: URL, bookName: String) -> URL? {
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return documentDirectory.appendingPathComponent(bookName).appendingPathComponent(url.lastPathComponent)
    }

    func createBookDirectory(name: String) {
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }

        let bookDirectory = documentDirectory.appendingPathComponent(name)
        if !fileManager.fileExists(atPath: bookDirectory.path) {
            do {
                try fileManager.createDirectory(at: bookDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                assertionFailure("Error: can't create book directory")
            }
        }
    }

    func ifBookExists(book: BookOnline) -> Bool {
        var result: Bool = false
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return false
        }
        let bookToCheck = documentDirectory.appendingPathComponent(book.label)
        (1...book.chaptersCount).forEach { (chapter) in
            let chapterPath = bookToCheck.appendingPathComponent(String(chapter)).appendingPathExtension("mp3")
            if fileManager.fileExists(atPath: chapterPath.path) {
                result = true
            }
        }
        return result
    }
}
