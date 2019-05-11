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

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        slider.setThumbImage(UIImage(named: "oval"), for: .normal)
        slider.setThumbImage(UIImage(named: "oval2"), for: .highlighted)
    }

    @IBAction func playButtonPressed(_ sender: Any) {
    }

    @IBAction func moveBackPressed(_ sender: Any) {
    }

    @IBAction func moveForwardPressed(_ sender: Any) {
    }

    @IBAction func previousPressed(_ sender: Any) {
    }

    @IBAction func nextPressed(_ sender: Any) {
    }

    func startPlaying(book: Book, from chapter: Int) {
        let chapterUrl = URL(string: book.bookUrl)?.appendingPathComponent(String(chapter)).appendingPathExtension("mp3")
        print(chapterUrl?.absoluteString)
    }
}
