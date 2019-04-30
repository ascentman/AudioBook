//
//  FileManager.swift
//  AudioBook
//
//  Created by user on 4/30/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class FileHandler {

    private let fileManager = FileManager.default
    private let books = "Books"
    private let images = "Images"

    var filelist : [URL]? {
        get {
            guard let files = booksDirectory else {
                return nil
            }
            let arrayOfUrl = try? fileManager.contentsOfDirectory(at: files, includingPropertiesForKeys: nil, options: [])
            return arrayOfUrl
        }
    }
    private var documentDirectory : URL? {
        get {
            guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
                return nil
            }
            return documentDirectory
        }
    }
    private var booksDirectory : URL? {
        get {
            guard let documentDirectory = documentDirectory else {
                return nil
            }
            return documentDirectory.appendingPathComponent(books, isDirectory: true)
        }
    }

    func createContactDirectory() throws {
        do {
            guard let contactDirectory = booksDirectory else { return }
            try fileManager.createDirectory(at: contactDirectory, withIntermediateDirectories: true, attributes: nil)
        } catch {
            throw ErrorToThrow.failToCreate
        }
    }

    func removeFile(from : String) throws {
        do {
            try fileManager.removeItem(atPath: from)
        } catch {
            throw ErrorToThrow.failToDelete
        }
    }
}
