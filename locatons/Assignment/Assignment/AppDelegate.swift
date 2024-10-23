//
//  AppDelegate.swift
//  Assignment
//
//  Created by Abdullah Saeed on 09/10/2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  private var appCoordinator: AppCoordinator?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = .init(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()

    guard let window = window else {
      return false
    }

    appCoordinator = .init(window: window)
    appCoordinator?.start()

    return true
  }

}
