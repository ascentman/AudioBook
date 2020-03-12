//
//  DetailsDataProvider.swift
//  AudioBook
//
//  Created by user on 4/30/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

enum LoadingStatus {
    case finished
    case partly
    case notStarted
}

final class DetailsDataProvider: NSObject {

    var chosenBook = Book()
    var playerViewController: PlayerViewController?
    let fileHandler = FileHandler()
    private var cells: [Int] {
        get {
            return [Int](1...chosenBook.chaptersCount)
        }
    }

    // MARK: - Public

    func fillChosen(book: Book) {
        self.chosenBook = book
    }

    func downloadSpecific(book: BookOnline, completion: (LoadingStatus) -> Void) {
        if !fileHandler.ifBookExists(book: book) {
            completion(.notStarted)
        } else if fileHandler.isBookChaptersLoaded(book: book) {
            completion(.finished)
        } else {
            completion(.partly)
        }
    }
}

// MARK: - Extensions

extension DetailsDataProvider: UICollectionViewDataSource {

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chosenBook.chaptersCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let chapter = cells[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChapterCollectionViewCell.identifier, for: indexPath) as? ChapterCollectionViewCell
        cell?.setCell(index: String(chapter))
        return cell ?? UICollectionViewCell()
    }
}

extension DetailsDataProvider: UICollectionViewDelegate {

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.backgroundColor = UIColor.lightGray
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)

        let bookOnline = BookOnline(label: chosenBook.label, previewURL: URL(string: chosenBook.bookUrl)!, chaptersCount: chosenBook.chaptersCount)
        
        let isLocal = fileHandler.isBookChaptersLoaded(book: bookOnline)
        playerViewController?.startPlaying(isLocal: isLocal, book: chosenBook, from: indexPath.row + 1)

    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.lightGray
    }
}

extension DetailsDataProvider: UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = (collectionView.frame.size.width) / 5
        return CGSize(width: collectionViewSize, height: collectionViewSize)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20)
    }
}
