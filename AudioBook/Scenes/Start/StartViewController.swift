//
//  StartViewController.swift
//  AudioBook
//
//  Created by user on 5/19/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class StartViewController: UIViewController {

    @IBOutlet weak var dotsLabel: UILabel!
    private let serialQueue = DispatchQueue(label: "com.audioBible.animatedLabel.queue")
    private let delay: TimeInterval = 1

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        dotsLabel.text = ""
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        serialQueue.asyncAfter(deadline: .now() + delay) {
            for char in "..." {
                DispatchQueue.main.async {
                    self.dotsLabel.text = self.dotsLabel.text! + String(char)
                }
                Thread.sleep(forTimeInterval: self.delay)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.performSegue(withIdentifier: "toMain", sender: self)
        }
    }
}
