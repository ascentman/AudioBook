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
    @IBOutlet weak var playerViewController: UIView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        playerView.layer.masksToBounds = true
        playerView.layer.cornerRadius = 10.0
        dataProvider.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)

        tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extensions

extension DetailsViewController: DetailsDataProviderDelegate {

    //MARK: - DetailsDataProviderDelegate

    func goToPlayer(_ choosenBook: Book, start chapter: Int) {
        let storyboard = UIStoryboard(name: StoryboardName.details, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: PlayerViewController.description()) as? PlayerViewController
        if let viewController = viewController {
            viewController.startPlaying(book: choosenBook, from: chapter)
        }
    }
}
