//
//  AnimatedLabel.swift
//  AudioBook
//
//  Created by user on 5/19/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class AnimatedLabel: UILabel {

    func showAnimated(_ text: String, delay: TimeInterval, completion: () -> ()) {
        let serialQueue = DispatchQueue(label: "com.audioBible.animatedLabel.queue")
//        let symbolsCount = text.count
//        let animationDuration = delay
//        let charAnimationInterval = animationDuration / TimeInterval(symbolsCount)

        serialQueue.async {
            for char in text {
                DispatchQueue.main.async {
                    self.text = text + String(char)
                }
                 Thread.sleep(forTimeInterval: delay)
            }
        }
    }
}
