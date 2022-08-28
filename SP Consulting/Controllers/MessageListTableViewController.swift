//
//  MessageListTableViewController.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-08-27.
//

import UIKit

class MessageListTableViewController: UITableViewController {
    
    fileprivate let messageListCell = "messageListCell"

    var mgMain : MgMain? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        tableView.register(UINib(nibName: "MessageListCell", bundle: nil), forCellReuseIdentifier: messageListCell)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return mgMain?.mgList?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: messageListCell, for: indexPath) as? MessageListCell else {
            return UITableViewCell()
        }
        
        if mgMain?.mgList?[indexPath.row]["mg_view"].stringValue == "Y" {
            cell.checkImageView.backgroundColor = #colorLiteral(red: 0.4867350459, green: 0.5169144273, blue: 0.6037136912, alpha: 1)
        } else {
            cell.checkImageView.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.9058823529, blue: 0.2980392157, alpha: 1)
        }
        
        cell.notiDate.text = mgMain?.mgList?[indexPath.row]["mg_create_date"].stringValue
        cell.listTitle.text = mgMain?.mgList?[indexPath.row]["mg_title"].stringValue
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MDVC") as? MessageDatailViewController else {
            return
        }
        vc.mdId = mgMain?.mgList?[indexPath.row]["mg_id"].stringValue
        //vc.url = API.MY_ACCOUNT
        //vc.title = self.titles[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let mgId = mgMain?.mgList?[indexPath.row]["mg_id"].stringValue {
                mgMain?.mgList?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                messageListDelete(mgId)
            }
        }
    }
    
    func messageListDelete(_ mdId : String) {
        let ud = UserDefaults.standard
        guard let auth_token = ud.string(forKey: "token") else {
            return
        }
        
            AlamofireManager
                .shared
                .getMessageBoxDetail(auth_token: auth_token, mode: "delete", mg_id: mdId, completion: {
                [weak self] result in
                guard let self = self else { return }
                    SwiftLoader.hide()
                switch result {
//                case .success(let result):
                case .success(let result):
                    print("result=====",result)
                case .failure(let error):
                    print("MessageListTableViewController - tapLoginButton.failure - error : \(error.rawValue)")
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
