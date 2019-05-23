//
//  PlayerViewController.swift
//  AudioBook
//
//  Created by user on 4/30/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import AVFoundation

protocol PlayerViewControllerDelegate: class {
    func updateCurrentChapter(all: Int, currentIndex: Int, toPlay: Int)
}

final class PlayerViewController: UIViewController {

    private enum Constants {
        static let seekDuration: Float64 = 10
        static let timeFormat: String = "%02d"
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

    private var currentBook: Book?
    private var currentChapter: Int = 1

    private var player: AVPlayer = AVPlayer()
    private let fileHandler = FileHandler()

    weak var delegate: PlayerViewControllerDelegate?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSlider()
        playButton.isUserInteractionEnabled = false
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
        
        if player.timeControlStatus == .playing {
            player.pause()
            setupImageForPlayButton(name: "play")
        } else if player.timeControlStatus == .paused {
            player.play()
            setupImageForPlayButton(name: "pause")
        }
    }

    @IBAction func moveBackPressed(_ sender: Any) {
        if !CMTimeGetSeconds(player.currentTime()).isNaN {
            var newTime = CMTimeGetSeconds(player.currentTime()) - Constants.seekDuration
            if newTime < 0 {
                newTime = 0
            }
            let time2: CMTime = CMTimeMake(value: Int64(newTime * 10 as Float64), timescale: 10)
            player.seek(to: time2, toleranceBefore: CMTime.indefinite, toleranceAfter: CMTime.indefinite)
        }
    }

    @IBAction func moveForwardPressed(_ sender: Any) {
        guard let duration = player.currentItem?.asset.duration else {
            return
        }
        let playerCurrentTime = CMTimeGetSeconds(player.currentTime())
        let newTime = playerCurrentTime + Constants.seekDuration
        if newTime < (CMTimeGetSeconds(duration) - Constants.seekDuration) {
            let time2: CMTime = CMTimeMake(value: Int64(newTime * 10 as Float64), timescale: 10)
            player.seek(to: time2, toleranceBefore: CMTime.indefinite, toleranceAfter: CMTime.indefinite)
        }
    }

    @IBAction func previousPressed(_ sender: Any) {
        previousChapterToPlay()
    }

    @IBAction func nextPressed(_ sender: Any) {
        nextChapterToPlay()
    }

    // Build Player
    func startPlaying(book: Book, from chapter: Int) {
        self.currentBook = book
        self.currentChapter = chapter
        playButton.isUserInteractionEnabled = true
        setupTitle(book: book, from: chapter)
        let startUrl = setupLocalUrl(book: book, from: chapter)
        let asset = AVAsset(url: startUrl!)
        let playerItem = AVPlayerItem(asset: asset)
        getTrackDuration(asset: asset)
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        setupImageForPlayButton(name: "pause")
        setupPeriodicTimeObserver(player: player, asset: asset)
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

    private func nextChapterToPlay() {
        if let currentBook = currentBook {
            if currentChapter < currentBook.chaptersCount {
                currentChapter += 1
                delegate?.updateCurrentChapter(all: currentBook.chaptersCount, currentIndex: currentChapter - 1, toPlay: currentChapter)
                startPlaying(book: currentBook, from: currentChapter)
            }
        }
    }

    private func previousChapterToPlay() {
        if let currentBook = currentBook {
            if currentChapter > 1 {
                currentChapter -= 1
                startPlaying(book: currentBook, from: currentChapter)
                delegate?.updateCurrentChapter(all: currentBook.chaptersCount, currentIndex: currentChapter + 1, toPlay: currentChapter)
            }
        }
    }

    // tracking time

    @objc private func playerDidFinishPlaying(sender: Notification) {
        nextChapterToPlay()
    }

    private func setupPeriodicTimeObserver(player: AVPlayer, asset: AVAsset) {
        let interval = CMTime(value: 1, timescale: 2)
        let durationSeconds = CMTimeGetSeconds(asset.duration)
        timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) {
            [weak self] progressTime in
            let seconds = CMTimeGetSeconds(progressTime)
            let minutesText = String(format: Constants.timeFormat, Int(seconds) / 60)
            let secondsText = String(format: Constants.timeFormat, Int(seconds) % 60)
            self?.currentTimeLabel.text = "\(minutesText):\(secondsText)"
            self?.slider.setValue(Float(seconds / durationSeconds), animated: true)
        }
    }

    func removePeriodicTimeObserver() {
        if let timeObserver = timeObserver {
            player.removeTimeObserver(timeObserver as Any)
        }
        timeObserver = nil
    }

    private func getTrackDuration(asset: AVAsset) {
        let seconds = CMTimeGetSeconds(asset.duration)
        let minutesText = String(format: Constants.timeFormat, Int(seconds) / 60)
        let secondsText = String(format: Constants.timeFormat, Int(seconds) % 60)
        self.durationLabel.text = "\(minutesText):\(secondsText)"
    }
}

