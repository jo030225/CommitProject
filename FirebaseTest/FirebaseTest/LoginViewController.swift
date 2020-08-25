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

class LoginViewController: UIViewController {

    @IBOutlet var loginEmailTextField: UITextField!
    @IBOutlet var loginPwdTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
