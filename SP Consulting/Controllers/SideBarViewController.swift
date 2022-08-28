//
//  SideBarViewController.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-05-30.
//

import UIKit

class SideBarViewController: UITableViewController {
    
    fileprivate let defaultCell = "menuCell"
    fileprivate let messageBox = "msgBox"
    fileprivate let signOut = "signOutCell"
    
    fileprivate var titles = [
        "My Account",
        "Account Timeline",
        "Message Box",
        "Contact Us",
        "Change Password",
        "Settings"
    ]
    
    var loginInfo : LoginInfo?
    var mgMain : MgMain?
    
//    let logoImageView: UIImageView = {
//        let aImageView = UIImageView()
//        aImageView.contentMode = UIView.ContentMode.scaleAspectFit
//        aImageView.frame.size.width = 116
//        aImageView.frame.size.height = 20
//        //aImageView.backgroundColor = .secondaryLabel
//        aImageView.image = UIImage(named: "logo_black")
//        return aImageView
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchMessageBoxList()
    }
    
    func fetchMessageBoxList() {
        let ud = UserDefaults.standard
        guard let auth_token = ud.string(forKey: "token") else {
            return
        }
        
            AlamofireManager
                .shared
    //            .getLoginInfo(id: email.text!, password: password.text!, completion: {
//                .checkTwoFactor(auth_token: API.TOKEN, mode: "confirm", sms_code: smsCode, completion: {
                .getMessageBoxList(auth_token: auth_token, mode: "list", completion: {
                [weak self] result in
                guard let self = self else { return }
                    SwiftLoader.hide()
                switch result {
//                case .success(let result):
                case .success(let result):
                    print("result=====",result)
                    self.mgMain = result
                    self.tableView.reloadData()
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

    /*
    let catImage = UIImage(named: "cat.jpg")
    let myImageView:UIImageView = UIImageView()
    myImageView.contentMode = UIView.ContentMode.scaleAspectFit
    myImageView.frame.size.width = 200
    myImageView.frame.size.height = 200
    myImageView.center = self.view.center
    myImageView.image = catImage
    view.addSubview(myImageView)
    */
    // MARK: - SetupUI
    func setupUI() {
        
        // Register the custom header and footer view.
        tableView.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "menuCell")
        tableView.register(UINib(nibName: "SignOutCell", bundle: nil), forCellReuseIdentifier: "signOutCell")
        
        tableView.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        
        
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                        "sectionHeader") as! CustomHeaderView
            return view
        default:
            return UIView(frame: .zero)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0...5:
            return 40
        case 6:
            return 200
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 120
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        switch section {
//        case 0:
            return self.titles.count + 1
//        case 1:
//            return 0
//        default:
//            return 0
//        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0...1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: defaultCell, for: indexPath) as? MenuCell else {
                return UITableViewCell()
            }
            
            //cell.textLabel?.text = self.titles[indexPath.row]
            cell.menuTitle.text = self.titles[indexPath.row]
            cell.messageCount.isHidden = true

        return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: defaultCell, for: indexPath) as? MenuCell else {
                return UITableViewCell()
            }
            
            //cell.textLabel?.text = self.titles[indexPath.row]
            cell.menuTitle.text = self.titles[indexPath.row]
            if let qty = mgMain?.m_total_qty {
                let qtyString = String(qty)
                cell.messageCount.isHidden = false
                cell.messageCount.text = qtyString
            }
            //cell.accessoryView = UIImageView(image: UIImage(named: "accessoryView"))

            /*
            let cell = tableView.dequeueReusableCell(withIdentifier: dafaultCell) ?? UITableViewCell(style: .value2, reuseIdentifier: dafaultCell)
            if let qty = mgMain?.m_qty {
                let qtyString = String(qty)
                cell.textLabel?.text = self.titles[indexPath.row] + qtyString
                //cell.detailTextLabel = detailLabel
                cell.detailTextLabel?.text = qtyString
            } else {
                cell.textLabel?.text = self.titles[indexPath.row]
            }
            cell.textLabel?.font = UIFont(name: "GeezaPro-Bold", size: 15)
            cell.accessoryView = UIImageView(image: UIImage(named: "accessoryView"))
             */
        return cell
        case 3...5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: defaultCell, for: indexPath) as? MenuCell else {
                return UITableViewCell()
            }
            
            //cell.textLabel?.text = self.titles[indexPath.row]
            cell.menuTitle.text = self.titles[indexPath.row]
            cell.messageCount.isHidden = true

        return cell
//        }
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: signOut) ?? UITableViewCell(style: .default, reuseIdentifier: signOut)
            return cell
        default:
            return UITableViewCell()
//
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let navi = self.storyboard?.instantiateViewController(withIdentifier: "MNC") as! MainNavigationController
        
        switch indexPath.row {
        case 0:
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "WVC") as? WebViewController else {
                return
            }
            vc.url = API.MY_ACCOUNT
            vc.title = self.titles[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            //navi.pushViewController(vc, animated: true)
        case 1:
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "WVC") as? WebViewController else {
                return
            }
            vc.url = API.ACCOUNT_TIMELINE
            vc.title = self.titles[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        
        case 2:
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MLTV") as? MessageListTableViewController else {
                return
            }
            vc.mgMain = self.mgMain
            vc.title = self.titles[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 3:
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "WVC") as? WebViewController else {
                return
            }
            vc.url = API.CONTACT_US
            vc.title = self.titles[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CPVC") as? ChangePasswordViewController else {
                return
            }
            vc.title = self.titles[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 5:
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SVC") as? SettingViewController else {
                return
            }
            vc.title = self.titles[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("defalut")
        }
    }
}
