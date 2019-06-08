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
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        addGestureRecognizer()
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
        monoImageView.image = UIImage(named: "mono")
        privateImageView.image = UIImage(named: "privat24New")
        monoLabel.text = "1122222414141451"
        privateLabel.text = "112222241414142"
    }

    private func addGestureRecognizer() {
        let tapMono = UITapGestureRecognizer(target: self, action: #selector(self.monoTapped(_:)))
        monoView.addGestureRecognizer(tapMono)

        let tapPrivate = UITapGestureRecognizer(target: self, action: #selector(self.privateTapped(_:)))
        privateView.addGestureRecognizer(tapPrivate)
    }

    @objc func monoTapped(_ sender: UITapGestureRecognizer) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = "1122222414141451"
        presentAlert("Інформація", message: "Номер картки Монобанку скопійовано", acceptTitle: "ОК", declineTitle: nil)
    }

    @objc func privateTapped(_ sender: UITapGestureRecognizer) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = "112222241414142"
        presentAlert("Інформація", message: "Номер картки Приватбанку скопійовано", acceptTitle: "ОК", declineTitle: nil)
    }

    private func showMailComposer() {
        guard MFMailComposeViewController.canSendMail() else {
            return
        }

        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["ascentman@icloud.com"])
        composer.setSubject("Відгук про Аудіо Біблію")
        present(composer, animated: true, completion: nil)
    }
}

extension SupportViewController: MFMailComposeViewControllerDelegate {

    // MARK: - MFMailComposeViewControllerDelegate

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
