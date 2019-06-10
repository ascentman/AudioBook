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

    func createBookDirectory(name: String) {
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }

        let bookDirectory = documentDirectory.appendingPathComponent(name)
        if !fileManager.fileExists(atPath: bookDirectory.path) {
            do {
                try fileManager.createDirectory(at: bookDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                assertionFailure("Error: can't create a book directory")
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

    func isBookChaptersLoaded(book: BookOnline) -> Bool {
        var result = false
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let bookToCheck = documentDirectory + "/" + book.label
        let dirContents = try? fileManager.contentsOfDirectory(atPath: bookToCheck)
        let count = dirContents?.count
        if count == book.chaptersCount {
            result = true
        }
        return result
    }

    func createBookArray() -> [String] {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        if let dirContents = try? fileManager.contentsOfDirectory(atPath: documentDirectory) {
            return dirContents
        }
        return []
    }

    func remove(book: BookOnline, completion: (Bool) -> ()) {
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }

        let bookDirectory = documentDirectory.appendingPathComponent(book.label)
        if fileManager.fileExists(atPath: bookDirectory.path) {
            do {
                try fileManager.removeItem(at: bookDirectory)
                completion(true)
            } catch {
                assertionFailure("no such file or directory")
                completion(false)
            }
        }
    }
}
