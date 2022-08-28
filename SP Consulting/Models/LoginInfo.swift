//
//  LoginInfo.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-08-07.
//

import Foundation

struct LoginInfo : Decodable {
    var last_name : String
    var middle_name : String
    var first_name : String
    var email : String
    var tel : String
    var id : String
}
