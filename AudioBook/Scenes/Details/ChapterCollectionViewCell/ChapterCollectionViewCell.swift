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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var downloadProgress: UIProgressView!

    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                    self?.contentView.backgroundColor = UIColor.orange
                }
            } else {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.transform = CGAffineTransform.identity
                    self?.contentView.backgroundColor = UIColor.lightGray
                }
            }
        }
    }

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
        backgroundColor = UIColor.lightGray
        activityIndicator.isHidden = true
    }

    // MARK: - Setup cell

    func setCell(index: String) {
        chapterNumber.text = index
    }

    func updateDownloadProgress(progress: Float) {
        chapterNumber.isHidden = true
        downloadProgress.isHidden = false
        percentageLabel.isHidden = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        downloadProgress.progress = progress
        percentageLabel.text = String(format: "%.0f", progress * 100)
    }

    func downloadCompleted() {
        activityIndicator.stopAnimating()
        downloadProgress.isHidden = true
        percentageLabel.isHidden = true
        chapterNumber.isHidden = false
        alpha = 1.0
    }

    // MARK: - Private

    private func setupUI() {
        layer.borderColor = Colors.appGreen.cgColor
        layer.borderWidth = 2.0
        downloadProgress.isHidden = true
        percentageLabel.isHidden = true
    }
}
