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

    private enum Constants {
        static let rtfFile = "About"
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupTextView()
    }

    // MARK: - Lifecycle

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        generalTextView.setContentOffset(CGPoint.zero, animated: false)
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
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.donateButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        UIView.animate(withDuration: 0.4, delay: 0.2, options: UIView.AnimationOptions.curveEaseInOut, animations: { [weak self] in
            self?.donateButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
        }, completion: nil)
    }

    private func setupTextView() {
        if let rtfPath = Bundle.main.url(forResource: Constants.rtfFile, withExtension: "rtf") {
            do {
                let attributedStringWithRtf = try NSAttributedString(url: rtfPath,
                                                                     options: [.documentType: NSAttributedString.DocumentType.rtf],
                                                                     documentAttributes: nil)
                generalTextView.attributedText = attributedStringWithRtf
            } catch {
                assertionFailure("No rtf content found!")
            }
        }
    }
}
