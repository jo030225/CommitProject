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

class LoginViewController: UIViewController, GIDSignInDelegate {

    @IBOutlet var loginEmailTextField: UITextField!
    @IBOutlet var loginPwdTextField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        ApplicationDelegate.shared.application( application, didFinishLaunchingWithOptions: launchOptions )
        

    }
    
    func goMainPage(){
        guard let goMain = self.storyboard?.instantiateViewController(identifier: "MainPage") else { return }
        goMain.modalPresentationStyle = .fullScreen
        self.present(goMain, animated: true)
    }
    
    func loginSuccessAlert(){
        let alert = UIAlertController(title: "로그인 성공", message: "로그인을 성공했습니다", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "확인", style: UIAlertAction.Style.default){ (_) in
            self.goMainPage()
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
       func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
         -> Bool {
            let google = GIDSignIn.sharedInstance().handle(url)
            
            let facebook = ApplicationDelegate.shared.application( application, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] )
            
            return google || facebook
       }
       
       func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
            let google = GIDSignIn.sharedInstance().handle(url)
        
            let facebook = URLContexts.first?.url else { return } ApplicationDelegate.shared.application( UIApplication.shared, open: url, sourceApplication: nil, annotation: [UIApplication.OpenURLOptionsKey.annotation] )
        
            return google || facebook
       }
       
       func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
         // ...
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
            if let error = error{
                
            } else {
                self.goMainPage()
            }
            
           
            Auth.auth().signIn(with: credential) { (authResult, error) in
               
           }
        
       }
    // 여기까지
    
    @IBAction func loginBtn(_ sender: Any) {
        Auth.auth().signIn(withEmail: loginEmailTextField.text!, password: loginPwdTextField.text!) { (user, error) in
                    if user != nil {
                        print("login success")
                        self.loginEmailTextField.text = ""
                        self.loginPwdTextField.text = ""
                        self.loginEmailTextField.placeholder = "이미 로그인 된 상태입니다."
                        self.loginPwdTextField.placeholder = "이미 로그인 된 상태입니다."
                        self.loginSuccessAlert()
                    }
                    else {
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
