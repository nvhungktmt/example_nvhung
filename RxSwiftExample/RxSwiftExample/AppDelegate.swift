//
//  AppDelegate.swift
//  RxSwiftExample
//
//  Created by Hung NV on 1/20/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        gotoHome()
        return true
    }
    
    
    
    func gotoHome(){
        let vc = RxTableViewExampleVC()
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()
    }
    
}

