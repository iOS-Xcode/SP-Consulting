//
//  Extension.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-05-27.
//

import Foundation
import UIKit

extension UIView {
    var mainBackgroundColor : UIColor {
        return UIColor(red: 55, green: 58, blue: 61, alpha: 1)
    }
    
    //Activity Indication

}

extension UIViewController {
    func showAlertView(_ title :  String? = "Error", _ msg : String)  {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
