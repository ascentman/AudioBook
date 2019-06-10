//
//  UICollectionView+Extensions.swift
//  AudioBook
//
//  Created by user on 4/24/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

extension UICollectionViewCell {

    // MARK: - UICollectionViewCell+BuildAction

    class var identifier: String {
        return String(describing: self)
    }

    class var nib: UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }

    class func deque(from collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        if type(of: cell) != self {
            fatalError("dequeueReusableCell can't be done")
        }
        return cell
    }

    class func register(for collectionView: UICollectionView) {
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
}
