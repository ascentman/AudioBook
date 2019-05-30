//
//  DetailsViewController.swift
//  AudioBook
//
//  Created by user on 4/25/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

private enum ActiveState {
    case downloading
    case normal
}

final class DetailsViewController: UIViewController {

    @IBOutlet var dataProvider: DetailsDataProvider!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var playerView: UIView!
    private var state: ActiveState = .normal
    private var bookOnline: BookOnline?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        dataProvider.playerViewController?.delegate = self

        DownloadService.shared.onProgress = { [weak self] (index, progress) in
            let indexPath = IndexPath(item: index - 1, section: 0)
            if let chapterCell = self?.collectionView.cellForItem(at: indexPath) as? ChapterCollectionViewCell {
                self?.state = .downloading
                self?.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
                chapterCell.updateDownloadProgress(progress: progress)
            }
        }

        DownloadService.shared.onCompleted = { [weak self] (index, chaptersCount) in
            let indexPath = IndexPath(item: index - 1, section: 0)
            if let chapterCell = self?.collectionView.cellForItem(at: indexPath) as? ChapterCollectionViewCell {
                chapterCell.downloadCompleted()
                if index == chaptersCount {
                    self?.state = .normal
                    print("done!!!")
                }
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

    @IBAction func downloadPressed(_ sender: Any) {
        let bookOnline = BookOnline(label: dataProvider.chosenBook.label,
                                previewURL: URL(string: dataProvider.chosenBook.bookUrl)!,
                                chaptersCount: dataProvider.chosenBook.chaptersCount)
        dataProvider.downloadSpecific(book: bookOnline) { status in
            switch status {
            case .finished:
                presentAlert("Інформація", message: "Усі розділи уже завантажені", acceptTitle: "Ok", declineTitle: nil)
            case .partly:
                presentAlert("Інформація", message: "Не всі розділи завантажені", acceptTitle: "Перезавантажити", declineTitle: nil, okActionHandler: {
                    DownloadService.shared.startDownload(bookOnline)
                }, cancelActionHandler: nil)
            case .notStarted:
                presentAlert("Інформація", message: "Завантажити цю книгу і слухати без інтернету?", acceptTitle: "Завантажити", declineTitle: "Скасувати", okActionHandler: {
                    DownloadService.shared.startDownload(bookOnline)
                }, cancelActionHandler: nil)
            }
        }
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
        setupCustomBackItem()
        collectionView.collectionViewLayout.invalidateLayout()
        playerView.layer.masksToBounds = true
        playerView.layer.cornerRadius = 10
        playerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private func setupCustomBackItem() {
        navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.backPressed(_:)))
        newBackButton.setBackgroundImage(UIImage(named: "back-arrow-circular-symbol"), for: .normal, barMetrics: .default)
        self.navigationItem.leftBarButtonItem = newBackButton
    }

    @objc func backPressed(_ sender: UIBarButtonItem) {
        if state == .downloading {
            presentAlert("Увага", message: "Скасувати завантаження", acceptTitle: "Продовжити", declineTitle: "Скасувати", okActionHandler: nil) { [weak self] in
                DownloadService.shared.cancelDownload()
                self?.navigationController?.popViewController(animated: true)
            }
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}


extension DetailsViewController: PlayerViewControllerDelegate {

    // MARK: - PlayerViewControllerDelegate

    func updateCurrentChapter(currentIndex: Int, toPlay: Int) {
        let indexPathCurrent = IndexPath(row: currentIndex - 1, section: 0)
        let indexPathToPlay = IndexPath(row: toPlay - 1, section: 0)
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.deselectItem(at: indexPathCurrent, animated: true)
            self?.collectionView.selectItem(at: indexPathToPlay, animated: true, scrollPosition: .centeredVertically)
        }
    }
}
