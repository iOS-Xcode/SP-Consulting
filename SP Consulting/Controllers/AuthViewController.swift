//
//  AuthViewController.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-05-27.
//

import UIKit

class AuthViewController: UIViewController {
    
    fileprivate var config : SwiftLoader.Config = SwiftLoader.Config()

    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var fourthTextField: UITextField!
    @IBOutlet weak var fifthTextField: UITextField!
    @IBOutlet weak var confirmButton: MainLargeButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        firstTextField.becomeFirstResponder()
        navigationItem.title = "Two-factor Authentication"
        confirmButton.alpha = 0.5
        
        config.size = 30
        config.backgroundColor = UIColor.clear
        config.spinnerColor = UIColor.white
        config.spinnerLineWidth = 2.0
        config.foregroundAlpha = 0.3
    }
    
    @IBAction func tapConfirmButton(_ sender: MainLargeButton) {
        SwiftLoader.setConfig(config)
        SwiftLoader.show(animated: true)
        
        if let first = firstTextField.text,  let second = secondTextField.text,  let  third = thirdTextField.text, let fourth = fourthTextField.text, let fifth = fifthTextField.text {
            let smsCode = first + second + third + fourth + fifth
            AlamofireManager
                .shared
    //            .getLoginInfo(id: email.text!, password: password.text!, completion: {
                .checkTwoFactor(auth_token: API.TOKEN, mode: "confirm", sms_code: smsCode, completion: {
                [weak self] result in
                guard let self = self else { return }
                    SwiftLoader.hide()
                print("result===",result)
                switch result {
//                case .success(let result):
                case .success:
                    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "RVVC") else {
                        return
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                    //self.present(vc, animated: true)
                    
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
    
    @IBAction func reSentCode(_ sender: UIButton) {
        AlamofireManager
            .shared
//            .getLoginInfo(id: email.text!, password: password.text!, completion: {
            .checkTwoFactor(auth_token: API.TOKEN, mode: "request", completion: {
            [weak self] result in
            guard let self = self else { return }
                SwiftLoader.hide()
            print("result===",result)
            switch result {
//                case .success(let result):
            case .success(let resultCode):
                self.showAlertView(nil, API.MESSAGE)
                print("resultCode",resultCode)
//                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "RVVC") else {
//                    return
//                }
//                self.navigationController?.pushViewController(vc, animated: true)
                
            case .failure(let error):
                print("LoginViewController - tapLoginButton.failure - error : \(error.rawValue)")
                switch error {
                case .invalidCode, .callAdmin, .unKnownError,  .smsCodeError:
                    //self.view.makeToast(API.MESSAGE)
                    self.showAlertView(nil, API.MESSAGE)
                default:
                    print("error")
                }
            }
        })
    }
    
    
}

extension AuthViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string != "") {
            
            if (textField.text == "") {
                textField.text = string
                let nextResponder: UIResponder? = view.viewWithTag(textField.tag + 1)
                if (nextResponder != nil) {
                    nextResponder?.becomeFirstResponder()
                }
            }
            //textFieldCheck()
        } else {
            
            textField.text = string
            
            let nextResponder: UIResponder? = view.viewWithTag(textField.tag - 1)
            if (nextResponder != nil) {
                nextResponder?.becomeFirstResponder()
            }
            //textFieldCheck()
        }
        textFieldCheck()
        return false

    }
    
    func textFieldCheck() {
        if (!firstTextField.text!.isEmpty && !secondTextField.text!.isEmpty && !thirdTextField.text!.isEmpty && !fourthTextField.text!.isEmpty && !fifthTextField.text!.isEmpty) {
            confirmButton.alpha = 1.0
            confirmButton.isEnabled = true
        } else {
            confirmButton.alpha = 0.5
            confirmButton.isEnabled = false
        }

    }
}
