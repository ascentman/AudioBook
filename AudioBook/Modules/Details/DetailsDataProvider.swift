//
//  DetailsDataProvider.swift
//  AudioBook
//
//  Created by user on 4/30/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class DetailsDataProvider: NSObject {

    var chosenBook = Book()
    var startChapter = 1
    var playerViewController: PlayerViewController?
    private var cells: [Int] {
        get {
            return [Int](1...chosenBook.chaptersCount)
        }
    }

    // MARK: - Public

    func fillChosen(book: Book) {
        self.chosenBook = book
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
        cell?.layer.cornerRadius = 10
        cell?.layer.masksToBounds = true
        cell?.setCell(index: String(chapter))
        return cell ?? UICollectionViewCell()
    }
}

extension DetailsDataProvider: UICollectionViewDelegate {

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.3, animations: {
            cell?.alpha = 1
            cell?.layer.transform = CATransform3DScale(CATransform3DIdentity, 0.9, 0.9, 0.9)
        })
        cell?.layer.transform = CATransform3DIdentity
        cell?.backgroundColor = UIColor.orange
        startChapter = indexPath.row + 1
        playerViewController?.startPlaying(book: chosenBook, from: startChapter)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.lightGray

    }
}

extension DetailsDataProvider: UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = (collectionView.frame.size.width) / 5
        return CGSize(width: collectionViewSize, height: collectionViewSize)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
    }
}

