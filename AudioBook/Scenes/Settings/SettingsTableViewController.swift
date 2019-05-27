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
    @IBOutlet private weak var speedStepper: UIStepper!
    @IBOutlet private weak var speedLabel: UILabel!

    //second section
    @IBOutlet private weak var rewindLabel: UILabel!
    @IBOutlet private weak var rewindStepper: UIStepper!

    //third section
    @IBOutlet weak var onlyDownloadedSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupSteppers()
    }

    // MARK: - Actions

    @IBAction func speedChangePressed(_ sender: UIStepper) {
        speedLabel.text = sender.value.description + "x"
    }

    @IBAction func timeChanfePressed(_ sender: UIStepper) {
        rewindLabel.text = Int(sender.value).description
    }
    @IBAction func showOnlyDownloadedPressed(_ sender: Any) {

    }

    // MARK: - Privates

    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Charter", size: 22)!]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }

    private func setupSteppers() {
        speedStepper.wraps = true
        speedStepper.autorepeat = true
        speedStepper.stepValue = 0.5
        speedStepper.minimumValue = 0.5
        speedStepper.maximumValue = 2

        rewindStepper.wraps = true
        rewindStepper.autorepeat = true
        rewindStepper.stepValue = 5
        rewindStepper.minimumValue = 5
        rewindStepper.maximumValue = 30
    }
}
