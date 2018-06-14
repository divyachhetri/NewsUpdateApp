//
//  WebViewController.swift
//  NewsUpdateApp
//
//  Created by Divya Pandit Chhetri on 6/12/18.
//  Copyright © 2018 Divya Pandit Chhetri. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
     var urlString = " "
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("**************Form 3 \(urlString)")

        let url : URL = URL(string: urlString)!
        let request: URLRequest = URLRequest(url: url)
        webView.load(request)
        
        
    }

  

}
