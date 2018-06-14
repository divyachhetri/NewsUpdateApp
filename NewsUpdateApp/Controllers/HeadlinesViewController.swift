//
//  ViewController.swift
//  NewsUpdateApp
//
//  Created by Divya Pandit Chhetri on 6/12/18.
//  Copyright © 2018 Divya Pandit Chhetri. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper
import AlamofireImage



class HeadlinesViewController: UIViewController {
    
    let webUrl = "https://newsapi.org/v2/top-headlines"
    var sourceId = " "
    var newsArticleArray = [DataModel]()
    var refresher : UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        refreshControl.tintColor = .gray
        return refreshControl
        
    }()
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkParameters()
        tableView.refreshControl = refresher
    }
    
    func getData(url : String, parameters : [String : String]){
        Alamofire.request(webUrl, method: .get, parameters: parameters).responseJSON { response in
            if response.result.isSuccess {
                print("Success")
                print(response.result.value!)
                if let jsonValue = (response.result.value!) as? [String : Any]{
                    if let jsonArray = jsonValue["articles"] as? Array<[String : Any]> {
                        for article in jsonArray {
                            guard let data = Mapper<DataModel>().map(JSON: article) else {continue}
                            self.newsArticleArray.append(data)
                        }
                        
                    }
                }
                self.tableView.reloadData()
                }
                
            else {
                print("Error :\(response.result.error!)")
            }
        }
        
    }
    
}
extension HeadlinesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeadlineCell", for: indexPath) as! HeadlineCell
        let news = newsArticleArray[indexPath.row]
        cell.headlineLabel.text = news.title
        if news.imageUrl != nil {
            if let url = URL(string: news.imageUrl!){
                 cell.newsImageView.af_setImage(withURL: url)
                
            }
            
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = UIStoryboard(name: "WebView", bundle: nil).instantiateViewController(withIdentifier:"WebViewController") as! WebViewController
        let item = newsArticleArray[indexPath.row]
        webVC.urlString = item.webUrl!
      self.navigationController?.pushViewController(webVC, animated: true)
        
    }
    func checkParameters() {
        if sourceId == "Skip" {
            let params = ["apiKey" : "d7f0471d43f74327b096bc720d70689b", "sortBy" : "latest", "country" : "us"]
            getData(url: webUrl, parameters: params)
            
        }
        else {
            let params = ["apiKey" : "d7f0471d43f74327b096bc720d70689b", "sortBy" : "latest", "sources" : sourceId]
            getData(url: webUrl, parameters: params)
            
        }
        
    }
    @objc func refreshContent() {
        newsArticleArray = []
        checkParameters()
        let delay = DispatchTime.now() + .milliseconds(700)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.tableView.reloadData()
            self.refresher.endRefreshing()
        }
    }
    
}


