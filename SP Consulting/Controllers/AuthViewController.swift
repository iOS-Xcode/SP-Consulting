//
//  AuthViewController.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-05-27.
//

import UIKit

class AuthViewController: UIViewController {
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var fourthTextField: UITextField!
    @IBOutlet weak var fifthTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTextField.becomeFirstResponder()
        navigationItem.title = "Two-factor Authentication"
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
            return false
        } else {
            
            textField.text = string
            
            let nextResponder: UIResponder? = view.viewWithTag(textField.tag - 1)
            if (nextResponder != nil) {
                nextResponder?.becomeFirstResponder()
            }
            //textFieldCheck()
            return false
        }
    }
    
    func textFieldCheck() {
        if (!firstTextField.text!.isEmpty && !secondTextField.text!.isEmpty && !thirdTextField.text!.isEmpty && !fourthTextField.text!.isEmpty) {
            //sendSMSButton.alpha = 1.0
            //sendSMSButton.isEnabled = true
        } else {
            //sendSMSButton.alpha = 0.3
            //sendSMSButton.isEnabled = false
        }

    }
}
