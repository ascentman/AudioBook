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
    @IBOutlet private weak var rightBarDownloadButton: UIBarButtonItem!
    @IBOutlet private weak var playerView: UIView!
    private var state: ActiveState = .normal
    private var bookOnline: BookOnline?

    private enum Constants {
        static let backItemImage = "back-arrow-circular-symbol"
        static let info = "Інформація"
        static let ok = "OK"
        static let cancel = "Скасувати"
        static let proceed = "Продовжити"
        static let reload = "Перезавантажити"
        static let download = "Завантажити"
        static let loading = "Завантаження у прогресі..."
        static let chaptersDownloaded = "Усі розділи уже завантажені"
        static let chaptersNotDownloaded = "Не всі розділи завантажені"
        static let downloadBook = "Завантажити цю книгу і слухати без інтернету?"
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        dataProvider.playerViewController?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        DownloadService.shared.onProgress = { [weak self] (index, progress) in
            let indexPath = IndexPath(item: index - 1, section: 0)
            if let chapterCell = self?.collectionView.cellForItem(at: indexPath) as? ChapterCollectionViewCell {
                self?.state = .downloading
                self?.rightBarDownloadButton.isEnabled = false
                self?.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
                chapterCell.updateDownloadProgress(progress: progress)
            }
        }

        DownloadService.shared.onCompleted = { [weak self] (index, chaptersCount) in
            let indexPath = IndexPath(item: index - 1, section: 0)
            if let chapterCell = self?.collectionView.cellForItem(at: indexPath) as? ChapterCollectionViewCell {
                chapterCell.downloadCompleted()
                if index <= chaptersCount {
                    self?.state = .normal
                    self?.rightBarDownloadButton.isEnabled = true
                    self?.collectionView.deselectItem(at: indexPath, animated: true)
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

    // MARK: - Actions

    @IBAction func downloadPressed(_ sender: Any) {
        bookOnline = BookOnline(label: dataProvider.chosenBook.label,
                                previewURL: URL(string: dataProvider.chosenBook.bookUrl)!,
                                chaptersCount: dataProvider.chosenBook.chaptersCount)

        guard let bookOnline = bookOnline else {
            return
        }

        dataProvider.downloadSpecific(book: bookOnline) { status in
            switch status {
            case .finished:
                presentAlert(Constants.info, message: Constants.chaptersDownloaded, acceptTitle: Constants.ok, declineTitle: nil)
            case .partly:
                presentAlert(Constants.info, message: Constants.chaptersNotDownloaded, acceptTitle: Constants.reload, declineTitle: nil, okActionHandler: {
                    DownloadService.shared.startDownload(bookOnline)
                }, cancelActionHandler: nil)
            case .notStarted:
                presentAlert(Constants.info, message: Constants.downloadBook, acceptTitle: Constants.download, declineTitle: Constants.cancel, okActionHandler: {
                    self.dataProvider.fileHandler.createBookDirectory(name: bookOnline.label)
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
        newBackButton.setBackgroundImage(UIImage(named: Constants.backItemImage), for: .normal, barMetrics: .default)
        self.navigationItem.leftBarButtonItem = newBackButton
    }

    @objc func backPressed(_ sender: UIBarButtonItem) {
        if state == .downloading {
            presentAlert(Constants.info, message: Constants.loading, acceptTitle: Constants.proceed, declineTitle: Constants.cancel, okActionHandler: nil) { [weak self] in
                DownloadService.shared.cancelDownload()
                if let book = self?.bookOnline {
                    self?.dataProvider.fileHandler.remove(book: book, completion: { _ in })
                }
                self?.navigationController?.popViewController(animated: true)
            }
        } else {
            navigationItem.leftBarButtonItem = nil
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

extension DetailsViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
