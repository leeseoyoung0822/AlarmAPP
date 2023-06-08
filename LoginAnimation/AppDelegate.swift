//
//  AppDelegate.swift
//  LoginAnimation
//
//  Created by 이서영 on 2023/05/18.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            KakaoSDK.initSDK(appKey: "5f241bc4f56e421def1dbb2738a7a6de")
        
        // Initialize Facebook SDK
            ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
   


}

