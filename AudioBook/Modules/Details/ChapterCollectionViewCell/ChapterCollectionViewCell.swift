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
    @IBOutlet private weak var percentageLabel: UILabel!
    @IBOutlet private weak var downloadProgress: UIProgressView!

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        chapterNumber.text = nil
        downloadProgress.isHidden = true
        percentageLabel.isHidden = true
    }

    // MARK: - Setup cell

    func setCell(index: String) {
        chapterNumber.text = index
    }

    func updateDownloadProgress(progress: Float) {
        downloadProgress.isHidden = false
        percentageLabel.isHidden = false
        downloadProgress.progress = progress
        percentageLabel.text = String(format: "%.1f%%", progress * 100)
    }

    func downloadCompleted() {
        downloadProgress.isHidden = true
        percentageLabel.isHidden = true
    }

    // MARK: - Private

    private func setupUI() {
        layer.borderColor = Colors.appGreen.cgColor
        layer.borderWidth = 2.0
        downloadProgress.isHidden = true
        percentageLabel.isHidden = true
    }
}
