//
//  ViewController.swift
//  NewsUpdateApp
//
//  Created by Divya Pandit Chhetri on 6/12/18.
//  Copyright © 2018 Divya Pandit Chhetri. All rights reserved.
//

import UIKit
import ObjectMapper
import AlamofireImage
import SwiftyJSON


class HeadlinesViewController: UIViewController {
    
    var getJson : Any?
    var sourceId = " "
    var newsArticleArray = [DataModel]()
    var callAPI : AlamofireAPI?
    
    private var refresher : UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        refreshControl.tintColor = .gray
        return refreshControl

    }()

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapData()
        tableView.refreshControl = refresher
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newsArticleArray = []
        self.mapData()

    }
}

extension HeadlinesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = newsArticleArray.isEmpty ? 1 : newsArticleArray.count
        return count
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeadlineCell", for: indexPath) as! HeadlineCell
        if newsArticleArray.isEmpty {
            cell.headlineLabel.text = "Error loading news. Please check your internet connection and try again."
            cell.newsSourceLabel.isHidden = true
            cell.newsImageView.isHidden = true
            
        }
        else {
            let news = newsArticleArray[indexPath.row]
            cell.headlineLabel.text = news.title
            cell.newsSourceLabel.text = news.source
            if news.imageUrl != nil {
                if let url = URL(string: news.imageUrl!){
                    cell.newsImageView.af_setImage(withURL: url)
                    
                }
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

    func mapData() {
//        if let jsonValue = getJson as? [String : Any] {
//            if let articles = jsonValue ["articles"] as? Array<[String : Any]> {
//                for article in articles{
//                    guard let data = Mapper<DataModel>().map(JSON: article) else {continue}
//                    self.newsArticleArray.append(data)
//                }
//            }
         let jsonValue = JSON(getJson!)
        if let jsonArray = jsonValue["articles"].arrayObject{
            let articles = jsonArray as! [[String : AnyObject]]
            for article in articles {
                guard let data = Mapper<DataModel>().map(JSON: article) else {continue}
                self.newsArticleArray.append(data)
            }
            
            tableView.reloadData()
        }
        else {
            print ("Error")
        }
        
        
    }

    @objc func refreshContent() {
        newsArticleArray = []
        callApi()
        let delay = DispatchTime.now() + .milliseconds(700)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.tableView.reloadData()
            self.refresher.endRefreshing()
        }
    }
    
    func callApi() {
        self.callAPI = AlamofireAPI(sourceId: sourceId)
        callAPI?.getData() { (response, error) in
            if let data = response {
                self.getJson = data
                self.mapData()
            }
            else {
                print("\(error!)")
            }
        }
        
    }
    
}


