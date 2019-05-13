//
//  PlayerViewController.swift
//  AudioBook
//
//  Created by user on 4/30/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {

    @IBOutlet private weak var slider: UISlider!
    @IBOutlet private weak var previousButton: UIButton!
    @IBOutlet private weak var moveBackButton: UIButton!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var moveForwardButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var trackLabel: UILabel!

    private var labelTitle = "" {
        didSet {
            trackLabel?.text = labelTitle
        }
    }
    var queuePlayer: AVQueuePlayer?
    let fileHandler = FileHandler()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        slider.setThumbImage(UIImage(named: "oval"), for: .normal)
        slider.setThumbImage(UIImage(named: "oval2"), for: .highlighted)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        trackLabel.text = labelTitle
    }

    @IBAction func playButtonPressed(_ sender: Any) {
        if queuePlayer?.timeControlStatus == .playing {
            queuePlayer?.pause()
            setupImageForPlayButton(name: "play")
        } else {
            queuePlayer?.play()
            setupImageForPlayButton(name: "pause")
        }
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
        setupTitle(book: book, from: chapter)
        let localUrl = setupLocalUrl(book: book, from: chapter)

        // setup player
        let asset = AVAsset(url: localUrl!)
        let playerItem = AVPlayerItem(asset: asset)
        queuePlayer = AVQueuePlayer(items: [playerItem])
        queuePlayer?.play()
        setupImageForPlayButton(name: "pause")
    }

    // MARK: - Private

    private func setupImageForPlayButton(name: String) {
        playButton.setImage(UIImage(named: name), for: .normal)
    }

    private func setupTitle(book: Book, from chapter: Int) {
        labelTitle = "\(book.name) - Розділ \(String(chapter))"
    }

    private func setupLocalUrl(book: Book, from chapter: Int) -> URL? {
        return fileHandler.documentDirectory?.appendingPathComponent(book.label).appendingPathComponent(String(chapter)).appendingPathExtension("mp3")
    }
}

