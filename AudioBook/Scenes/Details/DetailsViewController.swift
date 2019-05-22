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

        setupUI()

        dataProvider.playerViewController?.delegate = self

        DownloadService.shared.onProgress = { [weak self] (index, progress) in
            if let chapterCell = self?.collectionView.cellForItem(at: IndexPath(item: index - 1, section: 0)) as? ChapterCollectionViewCell {
                chapterCell.updateDownloadProgress(progress: progress)
            }
        }

        DownloadService.shared.onCompleted = { [weak self] (index) in
            if let chapterCell = self?.collectionView.cellForItem(at: IndexPath(item: index - 1, section: 0)) as? ChapterCollectionViewCell {
                chapterCell.downloadCompleted()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)

        tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let viewController as PlayerViewController:
            dataProvider.playerViewController = viewController
        default:
            break
        }
    }

    // MARK - Private

    private func setupUI() {
        collectionView.collectionViewLayout.invalidateLayout()
        playerView.layer.masksToBounds = true
        playerView.layer.cornerRadius = 10
        playerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}


extension DetailsViewController: PlayerViewControllerDelegate {
    func updateCurrentChapter(currentIndex: Int, toPlay: Int) {
        let indexPathCurrent = IndexPath(row: currentIndex - 1, section: 0)
        let indexToPlay = IndexPath(row: toPlay - 1, section: 0)
        if let toPlayCell = collectionView.cellForItem(at: indexToPlay),
            let currentCell = collectionView.cellForItem(at: indexPathCurrent) {
            currentCell.isSelected = false
            toPlayCell.isSelected = true
        }
    }


    // MARK: - PlayerViewControllerDelegate

    func updateCurrentChapter(index: Int) {
        let indexPathCurrent = IndexPath(row: index - 1, section: 0)
        let indexPathNext = IndexPath(row: index, section: 0)
        if let nextCell = collectionView.cellForItem(at: indexPathNext),
            let currentCell = collectionView.cellForItem(at: indexPathCurrent) {
            currentCell.isSelected = false
            nextCell.isSelected = true
        }
    }
}
