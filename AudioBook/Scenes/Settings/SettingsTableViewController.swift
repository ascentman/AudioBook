//
//  SettingsTableViewController.swift
//  AudioBook
//
//  Created by user on 5/19/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }

    // MARK: - Private

    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Charter", size: 22)!]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
}
