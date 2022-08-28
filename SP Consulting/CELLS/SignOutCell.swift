//
//  SignOutCell.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-08-07.
//

import UIKit

class SignOutCell: UITableViewCell {

    @IBOutlet weak var signOut: UIButton!
    
    @IBAction func tapLogOutButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SIGNOUT"), object: nil, userInfo: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        signOut.layer.masksToBounds = true
        signOut.layer.cornerRadius = 20
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
