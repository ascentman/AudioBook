//
//  PlayerViewController.swift
//  AudioBook
//
//  Created by user on 4/30/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var moveBackButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var moveForwardButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        slider.setThumbImage(UIImage(named: "oval"), for: .normal)
        slider.setThumbImage(UIImage(named: "oval2"), for: .highlighted)
    }
}
