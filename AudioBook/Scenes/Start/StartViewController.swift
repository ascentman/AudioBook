//
//  StartViewController.swift
//  AudioBook
//
//  Created by user on 5/19/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class StartViewController: UIViewController {

    private enum Constants {
        static let delay: TimeInterval = 0.3
        static let animatedLabelQueue = "com.audioBible.animatedLabel.queue"
        static let loadingText = "..."
    }

    @IBOutlet weak var dotsLabel: UILabel!
    private let serialQueue = DispatchQueue(label: Constants.animatedLabelQueue)

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        dotsLabel.text = ""
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        serialQueue.asyncAfter(deadline: .now() + Constants.delay) {
            for char in Constants.loadingText {
                DispatchQueue.main.async {
                    self.dotsLabel.text = self.dotsLabel.text! + String(char)
                }
                Thread.sleep(forTimeInterval: Constants.delay)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3 * Constants.delay) {
            self.performSegue(withIdentifier: "toMain", sender: self)
        }
    }
}
