//
//  SignUpViewController.swift
//  FirebaseTest
//
//  Created by 조주혁 on 2020/08/20.
//  Copyright © 2020 Ju-Hyuk Cho. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class SignUpViewController: UIViewController {

    @IBOutlet var signUpEmailTextField: UITextField!
    @IBOutlet var signUpPwdTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func backMain(){
        let loginPage = self.storyboard?.instantiateViewController(withIdentifier: "LoginPage")
        self.present(loginPage!, animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    func signUpSuccessAlert(){
        let alert = UIAlertController(title: "회원가입 성공", message: "회원가입을 성공했습니다", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
        alert.addAction(ok)
        self.present(alert, animated: false)
    }
    
    func signUpFailAlert(){
           let alert = UIAlertController(title: "회원가입 실패", message: "회원가입을 실패했습니다", preferredStyle: UIAlertController.Style.alert)
           let ok = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
           alert.addAction(ok)
           self.present(alert, animated: false)
       }
    
    @IBAction func signUpDone(_ sender: Any) {
        Auth.auth().createUser(withEmail: signUpEmailTextField.text!, password: signUpPwdTextField.text!
                  ) { (user, error) in
                      if user !=  nil{
                        print("register success")
                        self.signUpSuccessAlert()
                        self.backMain()
                      }
                      else{
                        print("register failed")
                        self.signUpEmailTextField.text = ""
                        self.signUpPwdTextField.text = ""
                        self.signUpFailAlert()
                      }
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
