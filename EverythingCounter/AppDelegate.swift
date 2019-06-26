//
//  AppDelegate.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/04/16.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let counterVC = CounterViewController()
        counterVC.reactor = CounterViewReactor()
        window.rootViewController = counterVC
        self.window = window
        self.window?.makeKeyAndVisible()
        return true
    }
}
