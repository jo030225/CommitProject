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
    
    @IBAction func loginBtn(_ sender: Any) {
        Auth.auth().signIn(withEmail: loginEmailTextField.text!, password: loginPwdTextField.text!) { (user, error) in
                    if user != nil {
                        print("login success")
                        self.loginEmailTextField.text = ""
                        self.loginPwdTextField.text = ""
                        self.loginEmailTextField.placeholder = "이미 로그인 된 상태입니다."
                        self.loginPwdTextField.placeholder = "이미 로그인 된 상태입니다."
                    }
                    else {
                        print("login fail")
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
