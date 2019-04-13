//
//  MainCollectionDataProvider.swift
//  AudioBook
//
//  Created by user on 4/13/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class MainCollectionDataProvider: NSObject {
    let dataManager = DataManager()
}

extension MainCollectionDataProvider: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? BookCollectionViewCell {
            cell.setCell(name: dataManager.elements[indexPath.row] + indexPath.row.description)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MainCollectionDataProvider: UICollectionViewDelegate {
    
}
