//
//  ForgotPasswordViewController.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-07-23.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    fileprivate var config : SwiftLoader.Config = SwiftLoader.Config()
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var birthday: UITextField!
    @IBOutlet weak var passport: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        config.size = 30
        config.backgroundColor = UIColor.clear
        config.spinnerColor = UIColor.white
        config.spinnerLineWidth = 2.0
        config.foregroundAlpha = 0.3
    }
    
    @IBAction func tapResetPassword(_ sender: MainLargeButton) {
        SwiftLoader.setConfig(config)
        SwiftLoader.show(animated: true)
        
        let ud = UserDefaults.standard
        guard let auth_token = ud.string(forKey: "token"), let email = email.text, let birthday = birthday.text,  let passport  = passport.text else {
            return
        }
        AlamofireManager
                .shared
    //            .getLoginInfo(id: email.text!, password: password.text!, completion: {
        
                .forgetPassword(auth_token: auth_token, mode: "reset-password", email: email, birthday: birthday, passport: passport, completion: {

                [weak self] result in
                guard let self = self else { return }
                    SwiftLoader.hide()
                switch result {
//                case .success(let result):
                case .success:
//                    self.showAlertView(nil, API.MESSAGE)
                    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "REVC") as? ResendEmailViewController else {
                        return
                    }
                    
                    vc.email = email
                    
                    self.navigationController?.pushViewController(vc, animated: true)
//                    self.navigationController?.popViewController(animated: true)
                    
                case .failure(let error):
                    print("LoginViewController - tapLoginButton.failure - error : \(error.rawValue)")
                    switch error {
                    case .invalidCode, .callAdmin, .unKnownError:
                        //self.view.makeToast(API.MESSAGE)
                        self.showAlertView(nil, API.MESSAGE)
                    default:
                        print("error")
                    }
                }
            })
        }
    
    }
