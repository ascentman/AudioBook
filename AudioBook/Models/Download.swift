//
//  Download.swift
//  AudioBook
//
//  Created by user on 5/5/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

class Download {

    var track: Track
    init(track: Track) {
        self.track = track
    }

    var task: URLSessionDownloadTask?
    var isDownloading = false
    var resumeData: Data?

    var progress: Float = 0

}
