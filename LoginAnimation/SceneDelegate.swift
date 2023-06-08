//
//  SceneDelegate.swift
//  LoginAnimation
//
//  Created by 이서영 on 2023/05/18.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
import FBSDKCoreKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    //카카오 url 로그인
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
            //facebook url 로그인
            ApplicationDelegate.shared.application(
                UIApplication.shared,
                open: url,
                sourceApplication: nil,
                annotation: [UIApplication.OpenURLOptionsKey.annotation]
            )
        }
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

