//
//  ChapterCollectionViewCell.swift
//  AudioBook
//
//  Created by user on 4/30/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class ChapterCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var chapterNumber: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var downloadProgress: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        layer.borderColor = Colors.appGreen.cgColor
        layer.borderWidth = 2.0
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        chapterNumber.text = nil
    }

    func setCell(index: String) {
        chapterNumber.text = index
    }

    func updateDownloadProgress(progress: Float, totalSize : String) {
        downloadProgress.isHidden = false
        percentageLabel.isHidden = false
        downloadProgress.progress = progress
        percentageLabel.text = String(format: "%.1f%%", progress * 100, totalSize)
    }

    func downloadCompleted() {
        downloadProgress.isHidden = true
        percentageLabel.isHidden = true
    }
}
