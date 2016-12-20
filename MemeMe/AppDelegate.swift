//
//  AppDelegate.swift
//  MemeMe
//
//  Created by Abdullah Althobetey on 12/12/16.
//  Copyright © 2016 Abdullah Althobetey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{

    var window: UIWindow?
    var memes = [Meme]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.
        return true
    }


}

