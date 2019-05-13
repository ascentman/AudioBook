//
//  DetailsViewController.swift
//  AudioBook
//
//  Created by user on 4/25/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class DetailsViewController: UIViewController {

    @IBOutlet var dataProvider: DetailsDataProvider!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var playerView: UIView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        playerView.layer.masksToBounds = true
        playerView.layer.cornerRadius = 10.0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)

        tabBarController?.tabBar.isHidden = false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let viewController as PlayerViewController:
            dataProvider.playerViewController = viewController
        default:
            break
        }
    }
}
