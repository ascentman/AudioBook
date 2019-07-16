//
//  HomeDataProvider.swift
//  AudioBook
//
//  Created by user on 4/24/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

protocol HomeDataProviderDelegate: class {
    func goToDetails(_ selectedSegment: Int, index: Int)
}

final class HomeDataProvider: NSObject {

    let dataManager = DataSource()
    var selectedSegment = 0
    weak var delegate: HomeDataProviderDelegate?
    var filteredNewTestament: [Book] = []
    var filteredOldTestament: [Book] = []
    var isSearchBarEmpty: Bool = true

    // MARK: - Search

    func filterBookForSearchedText(_ searchText: String, completion: () -> Void) {
        if selectedSegment == 0 {
            filteredNewTestament = dataManager.newTestament.filter( { book -> Bool in
                return book.name.lowercased().contains(searchText.lowercased())
            })
        } else {
            filteredOldTestament = dataManager.oldTestament.filter( { book -> Bool in
                return book.name.lowercased().contains(searchText.lowercased())
            })
        }
        completion()
    }
}

// MARK: - Extensions

extension HomeDataProvider: UICollectionViewDataSource {

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if selectedSegment == 0 {
            if !isSearchBarEmpty {
                return filteredNewTestament.count
            } else {
                return dataManager.newTestament.count
            }
        } else {
            if !isSearchBarEmpty {
                return filteredOldTestament.count
            } else {
                return dataManager.oldTestament.count
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell

        if selectedSegment == 0 {
            if !isSearchBarEmpty {
                cell?.setCell(book: filteredNewTestament[indexPath.row])
                return cell ?? UICollectionViewCell()
            } else {
                cell?.setCell(book: dataManager.newTestament[indexPath.row])
                return cell ?? UICollectionViewCell()
            }
        } else {
            if !isSearchBarEmpty {
                cell?.setCell(book: filteredOldTestament[indexPath.row])
                return cell ?? UICollectionViewCell()
            } else {
                cell?.setCell(book: dataManager.oldTestament[indexPath.row])
                return cell ?? UICollectionViewCell()
            }
        }
    }
}

extension HomeDataProvider: UICollectionViewDelegate {

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.goToDetails(selectedSegment, index: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8)

        UIView.animate(withDuration: 0.1, animations: {
            cell.alpha = 1
            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        })
    }
}

extension HomeDataProvider: UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize / 2 - 5, height: collectionViewSize / 3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10)
    }
}
