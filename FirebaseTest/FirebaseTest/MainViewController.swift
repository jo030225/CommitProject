//
//  MainViewController.swift
//  FirebaseTest
//
//  Created by 조주혁 on 2020/08/25.
//  Copyright © 2020 Ju-Hyuk Cho. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var testLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func back(){
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func backLoginPageBtn(_ sender: UIButton) {
        self.back()
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
