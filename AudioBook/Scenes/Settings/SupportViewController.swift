//
//  SupportViewController.swift
//  AudioBook
//
//  Created by user on 6/7/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import MessageUI

final class SupportViewController: UIViewController {

    @IBOutlet private weak var monoLabel: UILabel!
    @IBOutlet private weak var privateLabel: UILabel!
    @IBOutlet private weak var monoImageView: UIImageView!
    @IBOutlet private weak var privateImageView: UIImageView!
    @IBOutlet weak var monoView: UIView!
    @IBOutlet weak var privateView: UIView!

    private enum Constants {
        static let info = "Інформація"
        static let monoText = "Номер картки Монобанку скопійовано"
        static let privateText = "Номер картки Приватбанку скопійовано"
        static let monoNumber = "5375414100958965"
        static let monoImage = "mono"
        static let privateNumber = "5168755105375840"
        static let privateImage = "privat24New"
        static let ok = "OK"
        static let feedback = "Відгук про Аудіо Біблію"
        static let emailTo = "ascentman@icloud.com"
        static let mail = "На жаль, програма Mail у вас не налаштована. Ви можете відправити відгук через App Store"
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        addGestureRecognizer()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    // MARK: - Actions

    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func sendFeedbackPressed(_ sender: Any) {
        showMailComposer()
    }

    // MARK: - Private

    private func setupUI() {
        monoImageView.image = UIImage(named: Constants.monoImage)
        privateImageView.image = UIImage(named: Constants.privateImage)
        monoLabel.text = Constants.monoNumber
        privateLabel.text = Constants.privateNumber
    }

    private func addGestureRecognizer() {
        let tapMono = UITapGestureRecognizer(target: self, action: #selector(self.monoTapped(_:)))
        monoView.addGestureRecognizer(tapMono)

        let tapPrivate = UITapGestureRecognizer(target: self, action: #selector(self.privateTapped(_:)))
        privateView.addGestureRecognizer(tapPrivate)
    }

    @objc func monoTapped(_ sender: UITapGestureRecognizer) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = Constants.monoNumber
        presentAlert(Constants.info, message: Constants.monoText, acceptTitle: Constants.ok, declineTitle: nil)
    }

    @objc func privateTapped(_ sender: UITapGestureRecognizer) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = Constants.privateNumber
        presentAlert(Constants.info, message: Constants.privateText, acceptTitle: Constants.ok, declineTitle: nil)
    }

    private func showMailComposer() {
        guard MFMailComposeViewController.canSendMail() else {
            presentAlert(Constants.info, message: Constants.mail, acceptTitle: Constants.ok, declineTitle: nil)
            return
        }

        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([Constants.emailTo])
        composer.setSubject(Constants.feedback)
        present(composer, animated: true, completion: nil)
    }
}

extension SupportViewController: MFMailComposeViewControllerDelegate {

    // MARK: - MFMailComposeViewControllerDelegate

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension SupportViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
