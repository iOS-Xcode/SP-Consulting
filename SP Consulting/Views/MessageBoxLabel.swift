//
//  MessageBoxLabel.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-08-26.
//

import UIKit

class MessageBoxLabel: UILabel {
     required init(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)!
         self.commonInit()
     }
     override init(frame: CGRect) {
         super.init(frame: frame)
         self.commonInit()
     }
     func commonInit(){
         self.layer.cornerRadius = self.bounds.width/4
         self.clipsToBounds = true
         self.textColor = .white
         self.textAlignment = .center
         self.backgroundColor = .red
         //self.setProperties(borderWidth: 1.0, borderColor:.red)
     }
    
//     func setProperties(borderWidth: Float, borderColor: UIColor) {
//         self.layer.borderWidth = CGFloat(borderWidth)
//         self.layer.borderColor = borderColor.CGColor
//     }
 }
