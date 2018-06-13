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
    let params : [String : String] = ["apiKey" : "d7f0471d43f74327b096bc720d70689b", "country" : "us", "sortBy" : "latest"]
    var newsArticleArray = [DataModel]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(url: webUrl, parameters: params)
        
    }
    
    
    
    func getData(url : String, parameters : [String : String]){
        Alamofire.request(webUrl, method: .get, parameters: params).responseJSON { response in
            if response.result.isSuccess {
                print("Success")
                //print(response.result.value)
                if let jsonValue = (response.result.value!) as? [String : Any]{
                    if let jsonArray = jsonValue["articles"] as? Array<[String : Any]> {
                        for article in jsonArray {
                            guard let data = Mapper<DataModel>().map(JSON: article) else {continue}
                            self.newsArticleArray.append(data)
                            
                        }
                        //print(self.newsArticleArray.count)
                        
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
        print(newsArticleArray.count)
        return newsArticleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeadlineCell", for: indexPath) as! HeadlineCell
        let news = newsArticleArray[indexPath.row]
        cell.headlineLabel.text = news.title
        if news.imageUrl != nil {
             let url = URL(string: news.imageUrl!)
                cell.newsImageView.af_setImage(withURL: url!)
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = UIStoryboard(name: "WebView", bundle: nil).instantiateViewController(withIdentifier:"WebViewController") as! WebViewController
        let item = newsArticleArray[indexPath.row]
        webVC.urlString = item.webUrl!
      self.navigationController?.pushViewController(webVC, animated: true)
        
    }
    
    
}


