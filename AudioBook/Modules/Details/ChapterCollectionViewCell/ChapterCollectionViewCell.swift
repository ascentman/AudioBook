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
}
