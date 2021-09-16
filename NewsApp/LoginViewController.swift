//
//  LoginViewController.swift
//  NewsApp
//
//  Created by Takanashi on 2021/5/18.
//  Copyright © 2021 Takanashi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 登录
    @IBAction func btnLoginPressed(_ sender: UIButton) {
        let VCUserPwd = UserAndPasswordViewController()
        present(VCUserPwd, animated: true, completion: nil)
    }
}
