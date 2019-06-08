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
    func updateCurrentChapter(currentIndex: Int, toPlay: Int)
}

final class PlayerViewController: UIViewController {

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

    private enum Constants {
        static let seekDuration: Float64 = UserDefaults.standard.rewindTime
        static let timeFormat: String = "%02d"
        static let info = "Інформація"
        static let noInternetMessage = "На жаль, на даний момент відсутнє інтернет зєднання і дана книга не завантажена, щоб слухати її офлайн. Перепідключіться і спробуйте ще раз"
        static let ok = "ОK"
        static let playImage = "play"
        static let pauseImage = "pause"
        static let thumbImage = "oval"
        static let thumbImage2 = "oval2"
    }

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
            setupImageForPlayButton(name: Constants.playImage)
        } else if player.timeControlStatus == .paused {
            player.play()
            setupImageForPlayButton(name: Constants.pauseImage)
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
    func startPlaying(isLocal: Bool, book: Book, from chapter: Int) {
        self.currentBook = book
        self.currentChapter = chapter
        playButton.isUserInteractionEnabled = true
        setupTitle(book: book, from: chapter)
        var startUrl: URL?
        if isLocal {
            startUrl = setupLocalUrl(book: book, from: chapter)
        } else {
            if NetworkService.isConnectedToNetwork() {
                startUrl = URL(string: book.bookUrl)?.appendingPathComponent(String(chapter)).appendingPathExtension("mp3")
            } else {
                presentAlert(Constants.info, message: Constants.noInternetMessage, acceptTitle: Constants.ok, declineTitle: nil)
                return
            }
        }
        let asset = AVAsset(url: startUrl!)
        let playerItem = AVPlayerItem(asset: asset)
        getTrackDuration(asset: asset)
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        setupImageForPlayButton(name: Constants.pauseImage)
        setupPeriodicTimeObserver(player: player, asset: asset)
    
        let lastListened = "\(book.name) - розділ \(chapter)"
        UserDefaults.standard.updateLastListened(lastListened)
    }

    // MARK: - Private

    private func setupImageForPlayButton(name: String) {
        playButton.setImage(UIImage(named: name), for: .normal)
    }

    private func setupTitle(book: Book, from chapter: Int) {
        labelTitle = "\(book.name) - Розділ \(String(chapter))"
    }

    private func setupSlider() {
        slider.setThumbImage(UIImage(named: Constants.thumbImage), for: .normal)
        slider.setThumbImage(UIImage(named: Constants.thumbImage2), for: .highlighted)
    }

    private func setupLocalUrl(book: Book, from chapter: Int) -> URL? {
        return fileHandler.documentDirectory?.appendingPathComponent(book.label).appendingPathComponent(String(chapter)).appendingPathExtension("mp3")
    }

    private func nextChapterToPlay() {
        if let currentBook = currentBook {
            if currentChapter < currentBook.chaptersCount {
                currentChapter += 1
                delegate?.updateCurrentChapter(currentIndex: currentChapter - 1, toPlay: currentChapter)
                let bookOnline = BookOnline(label: currentBook.label, previewURL: URL(string: currentBook.bookUrl)!, chaptersCount: currentBook.chaptersCount)
                let isLocal = fileHandler.isBookChaptersLoaded(book: bookOnline)
                startPlaying(isLocal: isLocal, book: currentBook, from: currentChapter)
            }
        }
    }

    private func previousChapterToPlay() {
        if let currentBook = currentBook {
            if currentChapter > 1 {
                currentChapter -= 1
                delegate?.updateCurrentChapter(currentIndex: currentChapter + 1, toPlay: currentChapter)
                let bookOnline = BookOnline(label: currentBook.label, previewURL: URL(string: currentBook.bookUrl)!, chaptersCount: currentBook.chaptersCount)
                let isLocal = fileHandler.isBookChaptersLoaded(book: bookOnline)
                startPlaying(isLocal: isLocal, book: currentBook, from: currentChapter)
            }
        }
    }

    // tracking time

    @objc private func playerDidFinishPlaying(sender: Notification) {
        nextChapterToPlay()
    }

    private func setupPeriodicTimeObserver(player: AVPlayer, asset: AVAsset) {
        let interval = CMTime(seconds: 1.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let durationSeconds = CMTimeGetSeconds(asset.duration)
        timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) {
            [weak self] progressTime in

            if player.currentItem?.status == .readyToPlay {
                if let isPlaybackLikelyToKeepUp = self?.player.currentItem?.isPlaybackLikelyToKeepUp {
                    print("youououououo")
                }
            }

            let seconds = CMTimeGetSeconds(progressTime)
            let minutesText = String(format: Constants.timeFormat, Int(seconds) / 60)
            let secondsText = String(format: Constants.timeFormat, Int(seconds) % 60)
            self?.currentTimeLabel.text = "\(minutesText):\(secondsText)"
            self?.slider.isContinuous = false
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

