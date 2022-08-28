//
//  MgList.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-08-21.
//

import Foundation
import SwiftyJSON

struct MgMain : Decodable {
    var m_total_qty : Int
    var mgList : [JSON]? = []
}

struct MgList : Decodable {
    var mg_id : String
    var mg_title : String
    var mg_create_date : String
}

struct MgBox : Decodable {
    var md_id : String
    var mg_title : String
    var mg_content : String
    var mg_create_date : String
}
