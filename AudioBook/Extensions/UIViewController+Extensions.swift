//
//  UIViewController+Extensions.swift
//  AudioBook
//
//  Created by user on 4/30/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

extension UIViewController {

    open override func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    func presentAlert(_ title: String,
                      message : String,
                      acceptTitle: String,
                      declineTitle: String?,
                      okActionHandler:  (()->())? = nil,
                      cancelActionHandler:  (()->())? = nil) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: acceptTitle, style: .default) { _ in
            okActionHandler?()
        }
        alertController.addAction(settingsAction)

        if let declineTitle = declineTitle {
            let cancelAction = UIAlertAction(title: declineTitle, style: .cancel, handler: { _ in
                cancelActionHandler?()
            })
            alertController.addAction(cancelAction)
        }
        self.present(alertController, animated: true)
    }
}
