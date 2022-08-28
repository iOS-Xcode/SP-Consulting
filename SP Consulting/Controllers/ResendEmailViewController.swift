//
//  ResendEmailViewController.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-07-27.
//

import UIKit

class ResendEmailViewController: UIViewController {
    
    fileprivate var config : SwiftLoader.Config = SwiftLoader.Config()
    
    var email : String = ""
    
    @IBAction func tapResendEmail(_ sender: MainLargeButton) {
        SwiftLoader.setConfig(config)
        SwiftLoader.show(animated: true)
        
        let ud = UserDefaults.standard
        guard let auth_token = ud.string(forKey: "token") else {
            return
        }
        
        AlamofireManager
                .shared
                .forgetPassword(auth_token: auth_token, mode: "resend-password", email: email, completion: {

                [weak self] result in
                guard let self = self else { return }
                    SwiftLoader.hide()
                switch result {
//                case .success(let result):
                case .success:
                    self.showAlertView(nil, API.MESSAGE)
                case .failure(let error):
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
    
    @IBAction func backToLogin(_ sender: MainLargeButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config.size = 30
        config.backgroundColor = UIColor.clear
        config.spinnerColor = UIColor.white
        config.spinnerLineWidth = 2.0
        config.foregroundAlpha = 0.3
    }

}
