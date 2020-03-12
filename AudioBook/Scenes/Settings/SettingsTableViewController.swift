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
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var speedStepper: UIStepper!
    @IBOutlet private weak var autoPlaySwitch: UISwitch!
    // second section
    @IBOutlet private weak var historySwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupSettings()
        setupSteppers()
    }

    // MARK: - Actions

    @IBAction func timeChangePressed(_ sender: UIStepper) {
        rewindLabel.text = sender.value.description
        UserDefaults.standard.updateRewindTime(Float64(sender.value))
    }

    @IBAction func speedSwitchChanged(_ sender: UIStepper) {
        speedLabel.text = sender.value.description
        UserDefaults.standard.updateSpeed(Float(sender.value))
    }

    @IBAction func historySwitchPressed(_ sender: UISwitch) {
        UserDefaults.standard.updateHistorySaving(sender.isOn)
    }

    @IBAction func autoPlaySwitchPressed(_ sender: UISwitch) {
        UserDefaults.standard.updateAutoPlay(sender.isOn)
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
        rewindStepper.stepValue = 10.0
        rewindStepper.minimumValue = 10.0
        rewindStepper.maximumValue = 30.0

        speedStepper.wraps = true
        speedStepper.stepValue = round(10 * 0.2) / 10
        speedStepper.minimumValue = 1.0
        speedStepper.maximumValue = 1.4
    }

    private func setupSettings() {
        rewindLabel.text = String(UserDefaults.standard.rewindTime)
        speedLabel.text = String(UserDefaults.standard.speed)
        historySwitch.isOn = UserDefaults.standard.historySaving
        autoPlaySwitch.isOn = UserDefaults.standard.autoPlay
    }
}
