//
//  HomeViewController.swift
//  AudioBook
//
//  Created by user on 4/21/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet private var dataProvider: HomeDataProvider!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        BookCollectionViewCell.register(for: collectionView)
    }
}
