//
//  MessageListCell.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-08-27.
//

import UIKit

class MessageListCell: UITableViewCell {
    
    @IBOutlet weak var checkImageView: UIImageView!
    
    @IBOutlet weak var notiDate: UILabel!
    @IBOutlet weak var listTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkImageView.layer.masksToBounds = true
        checkImageView.layer.cornerRadius = checkImageView.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
