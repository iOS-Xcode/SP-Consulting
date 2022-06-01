//
//  SideBarViewController.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-05-30.
//

import UIKit

let id = "menuCell"

class SideBarViewController: UITableViewController {
    
    let titles = [
        "My Account",
        "Account Timeline",
        "Message Box",
        "Contact Us",
        "Change Password",
        "Settings"
    ]
    
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
        print("viewDidLoad")
        setupUI()
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
//        let v = UIView()
//        v.frame = CGRect(x: 0, y: 0, width: 116, height: 20)
//        //v.backgroundColor = .white
//        v.addSubview(logoImageView)
//        self.tableView.tableHeaderView = v
        // Register the custom header and footer view.
        tableView.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                    "sectionHeader") as! CustomHeaderView
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.textLabel?.font = UIFont(name: "GeezaPro-Bold", size: 15)
        cell.accessoryView = UIImageView(image: UIImage(named: "accessoryView"))

        return cell
    }

}
