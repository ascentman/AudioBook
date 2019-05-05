//
//  DetailsDataProvider.swift
//  AudioBook
//
//  Created by user on 4/30/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class DetailsDataProvider: NSObject {

    let fileHandler = FileHandler()
    var chosenBook = Book()
    let downloadService = DownloadService()
    lazy var downloadsSession: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "bgSessionConfiguration")
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()

    private var cells: [Int] {
        get {
            return [Int](1...chosenBook.chaptersCount)
        }
    }

    // MARK: - Public

    func fillChosen(book: Book) {
        self.chosenBook = book
    }
}

// MARK: - Extensions

extension DetailsDataProvider: UICollectionViewDataSource {

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chosenBook.chaptersCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let chapter = cells[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChapterCollectionViewCell.identifier, for: indexPath) as? ChapterCollectionViewCell
        cell?.layer.cornerRadius = 10
        cell?.layer.masksToBounds = true
        cell?.setCell(index: String(chapter))
        return cell ?? UICollectionViewCell()
    }
}

extension DetailsDataProvider: UICollectionViewDelegate {

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.3, animations: {
            cell?.alpha = 1
            cell?.layer.transform = CATransform3DScale(CATransform3DIdentity, 0.9, 0.9, 0.9)
        })
        cell?.layer.transform = CATransform3DIdentity
        cell?.backgroundColor = UIColor.orange
        print(chosenBook.label, indexPath.row + 1)

        // TODO
        let track = Track(name: "1111", artist: "33333", previewURL: URL(string: "https://www.audiobible.inf.ua/test/hope.mp3")!, index: 1)
        downloadService.startDownload(track)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = Colors.appGreen

    }
}

extension DetailsDataProvider: UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width / 5
        return CGSize(width: collectionViewSize, height: collectionViewSize)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}

extension DetailsDataProvider: URLSessionDownloadDelegate {

    // MARK: - URLSessionDownloadDelegate

    // Stores downloaded file
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let sourceURL = downloadTask.originalRequest?.url else {
            return
        }
        let download = downloadService.activeDownloads[sourceURL]
        downloadService.activeDownloads[sourceURL] = nil

        guard let destinationURL = fileHandler.localFilePath(for: sourceURL) else {
            return
        }
        print(destinationURL)

        let fileManager = FileManager.default
        try? fileManager.removeItem(at: destinationURL)
        do {
            try fileManager.copyItem(at: location, to: destinationURL)
            download?.track.downloaded = true
        } catch let error {
            print("Could not copy file to disk: \(error.localizedDescription)")
        }

//        if let index = download?.track.index {
//            DispatchQueue.main.async {
//                self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
//            }
//        }
    }
}

