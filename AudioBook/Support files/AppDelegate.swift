//
//  AppDelegate.swift
//  AudioBook
//
//  Created by user on 4/13/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -5), for: .default)
        return true
    }

    // MARK: Private

    private func setupInitialViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let startViewController = UIStoryboard(name: StoryboardName.start, bundle: nil).instantiateInitialViewController()
        window?.rootViewController = startViewController
        window?.makeKeyAndVisible()
    }
}
