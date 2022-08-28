//
//  LoginViewController.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-05-27.
//

import UIKit
//import Alamofire
//import Toast

class LoginViewController: UIViewController {
    
    fileprivate var config : SwiftLoader.Config = SwiftLoader.Config()

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.navigationController?.hideHairline()
        
        config.size = 30
        config.backgroundColor = UIColor.clear
        config.spinnerColor = UIColor.white
        config.spinnerLineWidth = 2.0
        config.foregroundAlpha = 0.3
    }
    
    //When tap login button
    @IBAction func tapLoginButton(_ sender: MainLargeButton) {
        SwiftLoader.setConfig(config)
        SwiftLoader.show(animated: true)
//        print(email.text, password.text)
        AlamofireManager
            .shared
            .getLoginInfo(id: email.text!, password: password.text!, completion: {
            [weak self] result in
            guard let self = self else { return }
            SwiftLoader.hide()
            switch result {
            case .success(let loginInfo):
//                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SBVC") as? SideBarViewController else {
//                    return
//                }
//
//                vc.loginInfo = loginInfo
                
                guard let rrvc = self.storyboard?.instantiateViewController(withIdentifier: "RVVC") as? RevealViewController else {
                    return
                }
                
                
                rrvc.loginInfo = loginInfo
                self.navigationController?.pushViewController(rrvc, animated: true)
                
                
            case .failure(let error):
                print("LoginViewController - tapLoginButton.failure - error : \(error.rawValue)")
                switch error {
                case .needToAuth:
                    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "AHVC") else {
                        return
                    }
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                case .noContent, .incorrectID, .noType, .noMember, .callAdmin:
                    //self.view.makeToast(API.MESSAGE)
                    self.showAlertView(nil, API.MESSAGE)
                default:
                    self.showAlertView(nil, API.MESSAGE)
                }
                //밑의 self는 약한 참조로..[weak self]에 의해
                //self.view.makeToast(error.rawValue, duration: 2.0, position: .center)
            }
        })
    }
    
    @IBAction func tapForgetPassword(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "FPVC") else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare = \(String(describing: segue.identifier))")
        switch segue.identifier {
        case SEGUE_ID.TERMS_WEBVIEW:
            //get next viewController
            let nextVC = segue.destination as! WebViewController
            nextVC.url = API.TERMS_CONDITIONS
            nextVC.title = TITLE.TERMS
        case SEGUE_ID.PRIVACY_WEBVIEW:
            //get next viewController
            let nextVC = segue.destination as! WebViewController
            nextVC.url = API.PRIVACY_POLICY
            nextVC.title = TITLE.PRIVACY
        /*
        case SEGUE_ID.PASSWORD_RESET:
            let nextVC = segue.destination as! ForgotPasswordViewController
            //nextVC.url = API.PRIVACY_POLICY
            nextVC.title = TITLE.FORGOTPASSWORD
         */
        //goToPrivacy
        default:
            print("error")
        }
    }
}

