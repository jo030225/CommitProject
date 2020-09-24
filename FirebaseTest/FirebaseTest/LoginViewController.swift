//
//  LoginViewController.swift
//  FirebaseTest
//
//  Created by 조주혁 on 2020/08/21.
//  Copyright © 2020 Ju-Hyuk Cho. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKPlacesKit


class LoginViewController: UIViewController, GIDSignInDelegate, LoginButtonDelegate {
    

    @IBOutlet var loginEmailTextField: UITextField!
    @IBOutlet var loginPwdTextField: UITextField!
    var isAutoLogin = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        GIDSignIn.sharedInstance().delegate = self
        
        let loginButton = FBLoginButton()
        loginButton.delegate = self
        loginButton.center = view.center
        view.addSubview(loginButton)
        loginButton.permissions = ["public_profile", "email"]
        
    }
    
    func goMainPage(){
        guard let goMain = self.storyboard?.instantiateViewController(identifier: "MainPage") else { return }
        goMain.modalPresentationStyle = .fullScreen
        self.present(goMain, animated: true)
    }
    
    func loginSuccessAlert(){
        let alert = UIAlertController(title: "로그인 성공", message: "로그인을 성공했습니다", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "확인", style: UIAlertAction.Style.default){ (_) in
            if self.isAutoLogin == true {
                if let user = Auth.auth().currentUser {
                    guard let dvc = self.storyboard?.instantiateViewController(identifier: "MainPage") as? MainViewController else { return }
                    self.present(dvc, animated: true, completion: nil)
                }
            } else {
                self.goMainPage()
            }
        }
        alert.addAction(ok)
        self.present(alert, animated: false)
    }
    
    func loginFailAlert(){
        let alert = UIAlertController(title: "로그인 실패", message: "로그인을 실패했습니다", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
        alert.addAction(ok)
        self.present(alert, animated: false)
    }
    
    
    
    
    
    
    
    // 구글 로그인
    // 여기부터
    @available(iOS 9.0, *)
       
    func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
           
        let facebook = ApplicationDelegate.shared.application( app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] )
               
        let google = GIDSignIn.sharedInstance().handle(url)
               
        return facebook || google
               
    }
       
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
         // ...
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        if let error = error{
            print("google login fail")
        } else {
            self.goMainPage()
        }
            
           
        Auth.auth().signIn(with: credential) { (authResult, error) in
               
        }
        
    }
    // 여기까지
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("facebook login fail")
            } else {
                self.goMainPage()
            }
         
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("logout success")
    }

 
    
    @IBAction func loginBtn(_ sender: Any) {
        Auth.auth().signIn(withEmail: loginEmailTextField.text!, password: loginPwdTextField.text!) { (user, error) in
            if user != nil {
                print("login success")
                self.loginEmailTextField.text = ""
                self.loginPwdTextField.text = ""
                self.loginEmailTextField.placeholder = "이미 로그인 된 상태입니다."
                self.loginPwdTextField.placeholder = "이미 로그인 된 상태입니다."
                self.loginSuccessAlert()
                if self.isAutoLogin == true {
                    
                }
            } else{
                print("login fail")
                self.loginFailAlert()
                self.loginEmailTextField.text = ""
                self.loginPwdTextField.text = ""
            }
        }

    }
    
    @IBAction func signUpBtn(_ sender: Any) {
    }
    
    @IBAction func signInButton(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func autoLoginBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true{
            isAutoLogin = false
            print("false")
        } else{
            isAutoLogin = true
            print("true")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


