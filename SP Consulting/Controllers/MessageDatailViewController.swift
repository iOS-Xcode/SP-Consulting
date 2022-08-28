//
//  MessageDatailViewController.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-08-27.
//

import UIKit

class MessageDatailViewController: UIViewController {
    
    @IBOutlet weak var mgDate: UILabel!
    @IBOutlet weak var mgTitle: UILabel!
    @IBOutlet weak var mgContent: UILabel!
    
    fileprivate var config : SwiftLoader.Config = SwiftLoader.Config()
    
    var mdId : String? = nil
    
    //var mgBox : MgBox? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config.size = 30
        config.backgroundColor = UIColor.clear
        config.spinnerColor = UIColor.darkGray
        config.spinnerLineWidth = 2.0
        config.foregroundAlpha = 0.3
        
        SwiftLoader.setConfig(config)
        SwiftLoader.show(animated: true)
        
        fetchMessageBoxList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func fetchMessageBoxList() {
        let ud = UserDefaults.standard
        guard let auth_token = ud.string(forKey: "token"), let mdId = self.mdId else {
            return
        }
        
            AlamofireManager
                .shared
                .getMessageBoxDetail(auth_token: auth_token, mode: "detail", mg_id: mdId, completion: {
                [weak self] result in
                guard let self = self else { return }
                    SwiftLoader.hide()
                switch result {
//                case .success(let result):
                case .success(let result):
                    print("result=====",result)
                    self.mgDate.text = result.mg_create_date
                    self.mgTitle.text = result.mg_title
                    self.mgContent.text = result.mg_content
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
