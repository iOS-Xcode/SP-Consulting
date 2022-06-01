//
//  CustomHeaderFooterView.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-05-30.
//

import Foundation
import UIKit

class CustomHeaderView: UITableViewHeaderFooterView {
    
    let logoImageView: UIImageView = {
        let aImageView = UIImageView()
        aImageView.contentMode = UIView.ContentMode.scaleAspectFit
        aImageView.frame.size.width = 116
        aImageView.frame.size.height = 20
        //aImageView.backgroundColor = .secondaryLabel
        aImageView.image = UIImage(named: "logo_black")
        return aImageView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupHeader()
        //setupFooter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHeader() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 116),
            logoImageView.heightAnchor.constraint(equalToConstant: 20),
            logoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
