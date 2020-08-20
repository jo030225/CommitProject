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
    
    @IBAction func signUpDone(_ sender: Any) {
        Auth.auth().createUser(withEmail: signUpEmailTextField.text!, password: signUpPwdTextField.text!
                  ) { (user, error) in
                      if user !=  nil{
                          print("register success")
                      }
                      else{
                          print("register failed")
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
