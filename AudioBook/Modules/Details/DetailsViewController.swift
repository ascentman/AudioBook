//
//  DetailsViewController.swift
//  AudioBook
//
//  Created by user on 4/25/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class DetailsViewController: UIViewController {

    @IBOutlet weak var detailsLabel: UILabel!

    private var detailsText = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        detailsLabel.text = detailsText
    }

    // MARK: - Public

    func fillDetails(_ text: String) {
        detailsText = text
    }
}
