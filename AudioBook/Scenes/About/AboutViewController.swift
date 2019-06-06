//
//  AboutViewController.swift
//  AudioBook
//
//  Created by user on 5/20/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class AboutViewController: UIViewController {

    @IBOutlet weak var generalTextView: UITextView!
    @IBOutlet weak var donateButton: UIButton!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        generalTextView.alwaysBounceVertical = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

         animateDonateButton()
    }

    // MARK: - Private

    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Charter", size: 22)!]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }

    private func animateDonateButton() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.donateButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        UIView.animate(withDuration: 0.5, delay: 0.3, options: UIView.AnimationOptions.curveEaseInOut, animations: { [weak self] in
            self?.donateButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
        }, completion: nil)
    }
}
