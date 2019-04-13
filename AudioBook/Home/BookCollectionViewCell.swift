//
//  BookCollectionViewCell.swift
//  AudioBook
//
//  Created by user on 4/13/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class BookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var someLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        someLabel.text = nil
    }
    
    func setCell(name: String) {
        someLabel.text = name
    }
}
