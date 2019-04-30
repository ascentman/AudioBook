//
//  BookCollectionViewCell.swift
//  AudioBook
//
//  Created by user on 4/21/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class BookCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var backTextView: UIView!
    @IBOutlet private weak var someLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backTextView.backgroundColor = UIColor.darkGray
        backTextView.layer.cornerRadius = 10
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        someLabel.text = nil
    }

    func setCell(book: Book) {
        someLabel.text = book.name
    }
}
