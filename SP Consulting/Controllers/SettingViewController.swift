//
//  SettingViewController.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-08-21.
//

import UIKit

class SettingViewController: UIViewController {

    @IBAction func tapNotificationSettings(_ sender: MainLargeButton) {
        if let bundle = Bundle.main.bundleIdentifier,
            let settings = URL(string: UIApplication.openSettingsURLString + bundle) {
            if UIApplication.shared.canOpenURL(settings) {
                UIApplication.shared.open(settings)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
