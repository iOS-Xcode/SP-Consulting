//
//  MainLargeButton.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-05-27.
//

import Foundation
import UIKit

class MainLargeButton: UIButton {
    
    //스토리보드에서도 객체를 초기화하기 위해서 초기화 메서드를 호출합니다.
    /*
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.8823529412, blue: 0.3254901961, alpha: 1)
        self.layer.cornerRadius = 22
        self.layer.masksToBounds = true
        self.titleLabel?.font = UIFont(name: "GeezaPro-Bold", size: 18)
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        print("MyHeartBtn - awakeFromNib() called")
        //configureAction()
        self.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.8823529412, blue: 0.3254901961, alpha: 1)
        self.layer.cornerRadius = 22
        self.layer.masksToBounds = true
        self.titleLabel?.font = UIFont(name: "GeezaPro-Bold", size: 18)
    }
}
