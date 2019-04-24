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
    @IBOutlet private weak var segmentedControl: CustomSegmentControl!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        BookCollectionViewCell.register(for: collectionView)
    }

    // MARK: - IBActions

    @IBAction func segmentControlClicked(_ sender: CustomSegmentControl) {
        if sender.selectedSegmentIndex == 0 {
            dataProvider.selectedSegment = 0
        } else {
            dataProvider.selectedSegment = 1
        }
        collectionView.reloadData()
    }
}
