//
//  Networking.swift
//  AudioBook
//
//  Created by user on 5/5/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

final class DownloadService: NSObject {

    static let shared = DownloadService()

    private override init() {}

    var activeDownloads: [URL: Download] = [:]
    lazy var downloadsSession: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "bgSessionConfiguration")
        configuration.httpMaximumConnectionsPerHost = 1
        configuration.timeoutIntervalForRequest = 120
        configuration.timeoutIntervalForResource = 120
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()

    var onProgress: ((Int, Float) -> ())?
    var onCompleted: ((Int, Int) -> ())?

    func startDownload(_ book: BookOnline) {
        (1...book.chaptersCount).forEach { (chapter) in
            let chapterUrl = book.previewURL.appendingPathComponent(String(chapter)).appendingPathExtension("mp3")
            let download = Download(track: book)
            download.task = downloadsSession.downloadTask(with: chapterUrl)
            download.task!.resume()
            download.isDownloading = true
            activeDownloads[chapterUrl] = download
        }
    }

    func pauseDownload(_ book: BookOnline) {
        guard let download = activeDownloads[book.previewURL] else { return }
        if download.isDownloading {
            download.task?.cancel(byProducingResumeData: { data in
                download.resumeData = data
            })
            download.isDownloading = false
        }
    }

    func cancelDownload() {
        activeDownloads.forEach { (_, value) in
            value.task?.cancel()
        }
        activeDownloads.removeAll()
    }

    func resumeDownload(_ book: BookOnline) {
        guard let download = activeDownloads[book.previewURL] else { return }
        if let resumeData = download.resumeData {
            download.task = downloadsSession.downloadTask(withResumeData: resumeData)
        } else {
            download.task = downloadsSession.downloadTask(with: download.track.previewURL)
        }
        download.task!.resume()
        download.isDownloading = true
    }

}

extension DownloadService: URLSessionDownloadDelegate {

    // MARK: - URLSessionDownloadDelegate

    // Stores downloaded file
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let sourceURL = downloadTask.originalRequest?.url else {
            return
        }
        let download = activeDownloads[sourceURL]
        activeDownloads[sourceURL] = nil

        let bookName = sourceURL.deletingLastPathComponent().lastPathComponent
        let fileManager = FileManager.default
        guard let destinationURL = fileManager.localFilePath(for: sourceURL, bookName: bookName) else {
            return
        }

        try? fileManager.removeItem(at: destinationURL)
        do {
            try fileManager.copyItem(at: location, to: destinationURL)
            download?.track.downloaded = true
        } catch let error {
            assertionFailure(error.localizedDescription)
        }
        if let index = Int(sourceURL.deletingPathExtension().lastPathComponent) {
            DispatchQueue.main.async {
                self.onCompleted?(index, ChaptersDict[bookName] ?? -1)
            }
        }
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {

        guard totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown else {
            return
        }

        guard let sourceURL = downloadTask.originalRequest?.url else {
            return
        }

        let progress = Double(Double(totalBytesWritten) / Double(totalBytesExpectedToWrite))

        if let index = Int(sourceURL.deletingPathExtension().lastPathComponent) {
            DispatchQueue.main.async {
                self.onProgress?(index, Float(progress))
            }
        }
    }
}

private extension FileManager {

    func localFilePath(for url: URL, bookName: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return documentDirectory.appendingPathComponent(bookName).appendingPathComponent(url.lastPathComponent)
    }
}
