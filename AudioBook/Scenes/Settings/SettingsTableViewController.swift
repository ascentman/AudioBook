//
//  SettingsTableViewController.swift
//  AudioBook
//
//  Created by user on 5/19/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class SettingsTableViewController: UITableViewController {

    // first section
    @IBOutlet private weak var rewindLabel: UILabel!
    @IBOutlet private weak var rewindStepper: UIStepper!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupSettings()
        setupSteppers()
    }

    // MARK: - Actions

    @IBAction func timeChanfePressed(_ sender: UIStepper) {
        rewindLabel.text = sender.value.description
        UserDefaults.standard.updateRewindTime(Float64(sender.value))
    }

    // MARK: - Private

    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Charter", size: 22)!]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }

    private func setupSteppers() {
        rewindStepper.wraps = true
        rewindStepper.autorepeat = true
        rewindStepper.stepValue = 5.0
        rewindStepper.minimumValue = 5.0
        rewindStepper.maximumValue = 30.0
    }

    private func setupSettings() {
        rewindLabel.text = String(UserDefaults.standard.rewindTime)
    }
}
