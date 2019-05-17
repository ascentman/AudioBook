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
    @IBOutlet weak var backImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        someLabel.text = nil

    }

    func setCell(book: Book) {
        someLabel.text = book.name
    }

    private func setupUI() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderColor = UIColor.white.cgColor

        backTextView.backgroundColor = UIColor.orange
        backTextView.layer.cornerRadius = 10
        backTextView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
}
