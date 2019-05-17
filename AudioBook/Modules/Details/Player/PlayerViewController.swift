//
//  PlayerViewController.swift
//  AudioBook
//
//  Created by user on 4/30/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import AVFoundation

final class PlayerViewController: UIViewController {

    private enum Constants {
        static let seekDuration: Float64 = 10
    }

    @IBOutlet private weak var slider: UISlider!
    @IBOutlet private weak var previousButton: UIButton!
    @IBOutlet private weak var moveBackButton: UIButton!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var moveForwardButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var trackLabel: UILabel!
    @IBOutlet private weak var currentTimeLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!

    private var timeObserver: Any?

    private var labelTitle = "" {
        didSet {
            trackLabel?.text = labelTitle
        }
    }

    private var playerItems: [AVPlayerItem] = []
    private var queuePlayer: AVQueuePlayer?
    private let fileHandler = FileHandler()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSlider()
        queuePlayer = AVQueuePlayer(items: playerItems)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        trackLabel.text = labelTitle
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        removePeriodicTimeObserver()
    }

    // MARK: - Actions

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
        let playerCurrentTime = CMTimeGetSeconds(queuePlayer?.currentTime() ?? CMTime.zero)
        var newTime = playerCurrentTime - Constants.seekDuration
        if newTime < 0 {
            newTime = 0
        }
        let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
        queuePlayer?.seek(to: time2, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
    }

    @IBAction func moveForwardPressed(_ sender: Any) {
        guard let duration = queuePlayer?.currentItem?.asset.duration else {
            return
        }
        let playerCurrentTime = CMTimeGetSeconds(queuePlayer?.currentTime() ?? CMTime.zero)
        let newTime = playerCurrentTime + Constants.seekDuration
        if newTime < (CMTimeGetSeconds(duration) - Constants.seekDuration) {
            let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
            queuePlayer?.seek(to: time2, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        }
    }

    @IBAction func previousPressed(_ sender: Any) {
    }

    @IBAction func nextPressed(_ sender: Any) {
    }

    // Build Player

    func startPlaying(book: Book, from chapter: Int) {
        setupTitle(book: book, from: chapter)
        let localUrl = setupLocalUrl(book: book, from: chapter)

        let asset = AVAsset(url: localUrl!)
        let playerItem = AVPlayerItem(asset: asset)
        queuePlayer?.replaceCurrentItem(with: playerItem)
        queuePlayer?.play()
        setupImageForPlayButton(name: "pause")
        if let queuePlayer = queuePlayer {
            getTrackDuration(player: queuePlayer)
            setupPeriodicTimeObserver(player: queuePlayer)
        }
    }

    // MARK: - Private

    private func setupImageForPlayButton(name: String) {
        playButton.setImage(UIImage(named: name), for: .normal)
    }

    private func setupTitle(book: Book, from chapter: Int) {
        labelTitle = "\(book.name) - Розділ \(String(chapter))"
    }

    private func setupSlider() {
        slider.setThumbImage(UIImage(named: "oval"), for: .normal)
        slider.setThumbImage(UIImage(named: "oval2"), for: .highlighted)
    }

    private func setupLocalUrl(book: Book, from chapter: Int) -> URL? {
        return fileHandler.documentDirectory?.appendingPathComponent(book.label).appendingPathComponent(String(chapter)).appendingPathExtension("mp3")
    }

    // tracking time

    private func setupPeriodicTimeObserver(player: AVQueuePlayer) {
        let interval = CMTime(value: 1, timescale: 2)
        guard let duration = player.currentItem?.asset.duration else {
            return
        }
        let durationSeconds = CMTimeGetSeconds(duration)
        timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) {
            [weak self] progressTime in
            let seconds = CMTimeGetSeconds(progressTime)
            let minutesText = String(format: "%02d", Int(seconds) / 60)
            let secondsText = String(format: "%02d", Int(seconds) % 60)
            self?.currentTimeLabel.text = "\(minutesText):\(secondsText)"
            UIView.animate(withDuration: 0.05, animations: { [weak self] in
                self?.slider.setValue(Float(seconds / durationSeconds), animated: true)
            })
        }
    }

    func removePeriodicTimeObserver() {
        if let timeObserver = timeObserver {
            queuePlayer?.removeTimeObserver(timeObserver as Any)
        }
        timeObserver = nil
    }

    private func getTrackDuration(player: AVQueuePlayer) {
        if let duration = player.currentItem?.asset.duration {
            let seconds = CMTimeGetSeconds(duration)
            let minutesText = String(format: "%02d", Int(seconds) / 60)
            let secondsText = String(format: "%02d", Int(seconds) % 60)
            self.durationLabel.text = "\(minutesText):\(secondsText)"
        }
    }
}

