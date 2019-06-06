//
//  AboutViewController.swift
//  AudioBook
//
//  Created by user on 5/20/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class AboutViewController: UIViewController {

    @IBOutlet weak var generalTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        generalTextView.alwaysBounceVertical = true
    }

    // MARK: - Private

    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Charter", size: 22)!]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
}
