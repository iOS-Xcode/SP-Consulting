//
//  MenuCell.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-08-27.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var menuTitle: UILabel!
    @IBOutlet weak var messageCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
