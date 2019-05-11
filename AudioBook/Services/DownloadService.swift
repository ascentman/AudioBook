//
//  Networking.swift
//  AudioBook
//
//  Created by user on 5/5/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

final class DownloadService {

    var downloadsSession: URLSession!
    var activeDownloads: [URL: Download] = [:]

    // MARK: - Download methods called by TrackCell delegate methods

    func startDownload(_ book: BookOnline) {
        (1...book.chaptersCount).forEach { (chapter) in
            let chapterUrl = book.previewURL.appendingPathComponent(String(chapter)).appendingPathExtension("mp3")
            let download = Download(track: book)
            download.task = downloadsSession.downloadTask(with: chapterUrl)
            download.task!.resume()
            download.isDownloading = true
            activeDownloads[download.track.previewURL] = download
        }
    }

//    func pauseDownload(_ track: BookOnline) {
//        guard let download = activeDownloads[track.previewURL] else { return }
//        if download.isDownloading {
//            download.task?.cancel(byProducingResumeData: { data in
//                download.resumeData = data
//            })
//            download.isDownloading = false
//        }
//    }
//
//    func cancelDownload(_ track: BookOnline) {
//        if let download = activeDownloads[track.previewURL] {
//            download.task?.cancel()
//            activeDownloads[track.previewURL] = nil
//        }
//    }

//    func resumeDownload(_ track: BookOnline) {
//        guard let download = activeDownloads[track.previewURL] else { return }
//        if let resumeData = download.resumeData {
//            download.task = downloadsSession.downloadTask(withResumeData: resumeData)
//        } else {
//            download.task = downloadsSession.downloadTask(with: download.track.previewURL)
//        }
//        download.task!.resume()
//        download.isDownloading = true
//    }

}
