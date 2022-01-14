//
//  AppDelegate.swift
//  SLTabBarDemo
//
//  Created by SL on 2022/1/10.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let tabBarVc = SLTabBarController()
        self.window?.rootViewController = tabBarVc
        return true
    }

 
}

