//
//  ViewController.swift
//  LoginAnimation
//
//  Created by 이서영 on 2023/05/18.
//

import UIKit
import FBSDKLoginKit
import KakaoSDKAuth
import KakaoSDKUser
import FBSDKCoreKit

class ViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var isLoggedIn = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.isHidden = true
        LoginButton.layer.cornerRadius = 30
        
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        view.addSubview(loginButton)
        
        
        // 종 이미지 뷰를 초기 위치로 설정
        imageView.transform = CGAffineTransform(translationX: 0, y: 100)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startShakingAnimation()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        if isLoggedIn{
//            LoginButton.isHidden = true
//        }
//    }

    //반복되고, 역방향으로 돌아오도록
    func startShakingAnimation() {
        UIView.animate(withDuration: 0.1, delay:0, options: [.autoreverse, .repeat], animations: {
            self.imageView.transform = CGAffineTransform(translationX: 0, y: -2)
        }) { _ in
            self.imageView.transform = .identity
        }
    }
    
    func stopShakingAnimation() {
        imageView.layer.removeAllAnimations()
    }
    
    @IBAction func KakaoLoginTapped(_ sender: Any) {
        stopShakingAnimation()
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
           if let error = error {
               print(error)
           }
           else {
               print("loginWithKakaoAccount() success.")
               self.isLoggedIn = true
               //self.LoginButton.isHidden = true
            
               //do something
               _ = oauthToken
               
               // 어세스토큰
               let accessToken = oauthToken?.accessToken
               
               //카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
               self.setUserInfo()
           }
        }
        
    }
    
    
    
    func setUserInfo() {
        //사용자 관리 api 호출
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
        //do something
                _ = user
                if let nickname = user?.kakaoAccount?.profile?.nickname{
                    self.infoLabel.text = "\(nickname)님"
                    self.infoLabel.isHidden = false
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    if let mainVC = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
                        mainVC.userInfo = self.infoLabel.text
                        mainVC.modalPresentationStyle = .fullScreen
                        mainVC.navigationItem.hidesBackButton = true
                        self.navigationController?.pushViewController(mainVC, animated: true)
                    }
                }
            }
        }
    }

}

