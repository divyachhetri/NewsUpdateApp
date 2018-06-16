//
//  WebViewController.swift
//  NewsUpdateApp
//
//  Created by Divya Pandit Chhetri on 6/12/18.
//  Copyright © 2018 Divya Pandit Chhetri. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
     var urlString = " "
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        let url : URL = URL(string: urlString)!
        let request: URLRequest = URLRequest(url: url)
        webView.load(request)
        
        
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        displayAlert()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        displayAlert()
    }

    func displayAlert () {
        
        let alert = UIAlertController (title: "Error Loading!", message: "Something went wrong. Please try again.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }

}
