//
//  ChangePasswordViewController.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-08-21.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    fileprivate var config : SwiftLoader.Config = SwiftLoader.Config()

    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var setPassword: MainLargeButton!
    
    @IBAction func tapSetPassword(_ sender: MainLargeButton) {
        SwiftLoader.setConfig(config)
        SwiftLoader.show(animated: true)
        
        let ud = UserDefaults.standard
        guard let auth_token = ud.string(forKey: "token"), let  newPassword = newPassword.text, let confirmPassword = confirmPassword.text else {
            return
        }
        AlamofireManager
                .shared
    //            .getLoginInfo(id: email.text!, password: password.text!, completion: {
                .changePassword(auth_token: auth_token, mode: "change-password", password: newPassword, confirm_password: confirmPassword, completion: {

                [weak self] result in
                guard let self = self else { return }
                    SwiftLoader.hide()
                switch result {
//                case .success(let result):
                case .success:
                    self.showAlertView(nil, API.MESSAGE)

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        config.size = 30
        config.backgroundColor = UIColor.clear
        config.spinnerColor = UIColor.white
        config.spinnerLineWidth = 2.0
        config.foregroundAlpha = 0.3
        
        newPassword.layer.masksToBounds = true
        newPassword.layer.borderWidth = 1.0
        newPassword.layer.borderColor = UIColor.darkGray.cgColor
        newPassword.layer.cornerRadius = 10
        
        confirmPassword.layer.masksToBounds = true
        confirmPassword.layer.borderWidth = 1.0
        confirmPassword.layer.borderColor = UIColor.darkGray.cgColor
        confirmPassword.layer.cornerRadius = 10
    }

}

extension ChangePasswordViewController : UITextFieldDelegate {
    /*
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let strippedString = string
        // replace current content with stripped content
        if let replaceStart = textField.position(from: textField.beginningOfDocument, offset: range.location),
            let replaceEnd = textField.position(from: replaceStart, offset: range.length),
            let textRange = textField.textRange(from: replaceStart, to: replaceEnd) {
            
            textField.replace(textRange, withText: strippedString)
        }
        
        print("textField.text = ",textField.text ?? "")

        if ((newPassword.text?.isEmpty == false) && (confirmPassword.text?.isEmpty == false)) && (newPassword.text == confirmPassword.text) {
            setPassword.isEnabled = true
            setPassword.alpha = 1.0
        } else {
            setPassword.isEnabled = false
            setPassword.alpha = 0.5
            //return false
        }
        return true
    }
     */
}
