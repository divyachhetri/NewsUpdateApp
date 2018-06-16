//
//  DataModel.swift
//  NewsUpdateApp
//
//  Created by Divya Pandit Chhetri on 6/12/18.
//  Copyright © 2018 Divya Pandit Chhetri. All rights reserved.
//

import Foundation
import ObjectMapper

class DataModel : Mappable {
    var title : String?
    var imageUrl : String?
    var webUrl : String?
    var source : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        title <- map["title"]
        webUrl <- map["url"]
       imageUrl <- map["urlToImage"]
        source <- map["source.name"]

    }
    
}

