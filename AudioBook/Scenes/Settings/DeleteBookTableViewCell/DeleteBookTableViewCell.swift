//
//  DeleteBookTableViewCell.swift
//  AudioBook
//
//  Created by user on 5/29/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class DeleteBookTableViewCell: UITableViewCell {

    @IBOutlet private weak var deleteBookLabel: UILabel!

    // MARK: - Lifecycle

    override func prepareForReuse() {
        deleteBookLabel.text = nil
    }

    // MARK: - Private

    func setBook(name: String) {
        deleteBookLabel.text = name
    }
}
