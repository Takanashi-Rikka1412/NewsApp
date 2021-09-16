//
//  UserAndPasswordViewController.swift
//  NewsApp
//
//  Created by Takanashi on 2021/5/18.
//  Copyright © 2021 Takanashi. All rights reserved.
//

import UIKit

class UserAndPasswordViewController: UIViewController
{
    let defaults = UserDefaults.standard  // 用户偏好
    var txtUser: UITextField!  // 用户名（2019302120079）
    var txtPwd: UITextField!   // 密码（123）
    var btnLogin: UIButton!    // 登录按钮
    var btnCancel: UIButton!   // 取消登录按钮
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 获取屏幕尺寸
        let mainSize = UIScreen.main.bounds.size
        
        // 登录框背景
        let vLogin = UIView(frame: CGRect(x: 15, y: 200, width: mainSize.width - 30, height: 250))
        vLogin.layer.cornerRadius = 5
        vLogin.layer.borderWidth = 0.5
        vLogin.layer.backgroundColor = UIColor(red: 135/255, green: 206/255, blue: 235/255, alpha: 1).cgColor
        vLogin.layer.borderColor = UIColor.lightGray.cgColor
        self.view.addSubview(vLogin)
        
        // 用户名输入框
        txtUser = UITextField(frame: CGRect(x: 30, y: 30, width: vLogin.frame.size.width - 60, height: 44))
        txtUser.layer.cornerRadius = 5
        txtUser.layer.borderColor = UIColor.lightGray.cgColor
        txtUser.layer.backgroundColor = UIColor.white.cgColor
        txtUser.layer.borderWidth = 0.5
        txtUser.autocapitalizationType = .none
        txtUser.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        txtUser.leftViewMode = UITextField.ViewMode.always
        
        // 用户名输入框左侧图标
        let imgUser = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgUser.image = UIImage(named: "iconfont-user")
        txtUser.leftView!.addSubview(imgUser)
        vLogin.addSubview(txtUser)
        
        // 密码输入框
        txtPwd = UITextField(frame: CGRect(x: 30, y:90, width: vLogin.frame.size.width - 60, height: 44))
        txtPwd.layer.cornerRadius = 5
        txtPwd.layer.borderColor = UIColor.lightGray.cgColor
        txtPwd.layer.backgroundColor = UIColor.white.cgColor
        txtPwd.layer.borderWidth = 0.5
        txtPwd.isSecureTextEntry = true
        txtPwd.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        txtPwd.leftViewMode = UITextField.ViewMode.always
        
        // 密码输入框左侧图标
        let imgPwd = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgPwd.image = UIImage(named: "iconfont-password")
        txtPwd.leftView!.addSubview(imgPwd)
        vLogin.addSubview(txtPwd)
        
        // 添加登录按钮
        btnLogin = UIButton(frame: CGRect(x: vLogin.frame.size.width/2 - 120 - 25, y: 150, width: 120, height: 50))
        btnLogin.setTitle("登录", for: .normal)
        btnLogin.setBackgroundImage(UIImage(named:  "buttonbg"), for: .normal)
        //btnLogin.backgroundColor = UIColor.gray
        vLogin.addSubview(btnLogin)
        
        // 添加取消登录按钮
        btnCancel = UIButton(frame: CGRect(x: vLogin.frame.size.width/2 + 25, y: 150, width: 120, height: 50))
        btnCancel.setTitle("取消", for: .normal)
        btnCancel.setBackgroundImage(UIImage(named:  "buttonbg"), for: .normal)
        //btnCancel.backgroundColor = UIColor.gray
        vLogin.addSubview(btnCancel)
        
        // 添加action
        btnLogin.addTarget(self, action: #selector(loginEvent), for: .touchUpInside)
        btnCancel.addTarget(self, action: #selector(cancelEvent), for: .touchUpInside)
        
        // 填入上次登录用户名
        txtUser.text = defaults.string(forKey: "UserName")
    }
    
    @objc func loginEvent()
    {
        let userName = txtUser.text!
        let password = txtPwd.text!
        txtUser.resignFirstResponder()
        txtPwd.resignFirstResponder()
        
        if userName == "2019302120079" && password == "123"
        {
            let mainBoard: UIStoryboard! = UIStoryboard(name: "Main", bundle: nil)
            let VCMain = mainBoard!.instantiateViewController(withIdentifier: "vcMain")
            
            UIApplication.shared.windows[0].rootViewController = VCMain
            
            defaults.set(userName, forKey: "UserName")
        }
        else
        {
            let p = UIAlertController(title: "登录失败", message: "用户名或密码错误", preferredStyle: .alert)
            p.addAction(UIAlertAction(title: "确定", style: .default, handler: {
                (act: UIAlertAction) in self.txtPwd.text = ""
            }))
            present(p, animated: false, completion: nil)
        }
        
    }
    
    @objc func cancelEvent()
    {
        self.dismiss(animated: true, completion: nil)
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
