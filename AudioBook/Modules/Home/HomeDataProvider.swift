//
//  HomeDataProvider.swift
//  AudioBook
//
//  Created by user on 4/24/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class HomeDataProvider: NSObject {
    let dataManager = DataManager()
    var selectedSegment = 0

}

// MARK: - Extensions

extension HomeDataProvider: UICollectionViewDataSource {

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedSegment == 0 {
            return dataManager.new.count
        } else {
            return dataManager.old.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell
        if selectedSegment == 0 {
            cell?.setCell(name: dataManager.new[indexPath.row] + indexPath.row.description)
            return cell ?? UICollectionViewCell()
        } else {
            cell?.setCell(name: dataManager.old[indexPath.row] + indexPath.row.description)
            return cell ?? UICollectionViewCell()
        }
    }
}

extension HomeDataProvider: UICollectionViewDelegate {

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8)

        UIView.animate(withDuration: 0.3, animations: {
            cell.alpha = 1
            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        })
    }
}

extension HomeDataProvider: UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize / 2, height: collectionViewSize / 3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
