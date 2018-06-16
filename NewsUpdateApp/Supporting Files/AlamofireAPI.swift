//
//  APICall.swift
//  NewsUpdateApp
//
//  Created by Divya Pandit Chhetri on 6/14/18.
//  Copyright © 2018 Divya Pandit Chhetri. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireAPI {
    let webUrl = "https://newsapi.org/v2/top-headlines"
    var sourceId : String
    var dataValue = WelcomeViewController()
    
    init(sourceId : String) {
        self.sourceId = sourceId
    }
    
    func getData(responseHandler: @escaping (Any?, Error?) -> Void) {
        var params : [String : String] = [:]
        if sourceId == "Skip" {
          params = ["apiKey" : "d7f0471d43f74327b096bc720d70689b", "sortBy" : "latest", "country" : "us"]
        } else{
            params = ["apiKey" : "d7f0471d43f74327b096bc720d70689b", "sortBy" : "latest", "sources" : sourceId]
        }
            Alamofire.request(webUrl, method: .get, parameters: params).responseJSON { response in
            switch(response.result) {
            case .success (let value):
                responseHandler(value,nil)
            case .failure (let error):
                responseHandler(nil, error)
                print("Error getting value")
                }
        }
     
 }

}

