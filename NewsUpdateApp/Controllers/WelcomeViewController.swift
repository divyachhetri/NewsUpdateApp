//
//  WelcomeViewController.swift
//  NewsUpdateApp
//
//  Created by Divya Pandit Chhetri on 6/13/18.
//  Copyright © 2018 Divya Pandit Chhetri. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
 
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var weekDayLabel: UILabel!
    
    let vc = UIStoryboard(name: "TopStories", bundle: nil).instantiateViewController(withIdentifier: "HeadlinesViewController") as! HeadlinesViewController
    let data = NewsSources()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        updateDate()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.newsSource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourceCell", for: indexPath) as! SourceViewCell
        cell.sourceNameLabel.text = data.newsSource[indexPath.row]
        cell.iconImageView.image = UIImage(named: data.newsSourceIcon[indexPath.row])
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        vc.sourceId = data.newsSourceId[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func skipbuttonPressed(_ sender: UIButton) {
        
        vc.sourceId = "Skip"
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateDate(){
        
        let days = ["Sunday","Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        let calendar = Calendar.current
        let date = Date()
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let weekday = calendar.component(.weekday, from: date)
        dateLabel.text = "\(month)/\(day)/\(year)"
        weekDayLabel.text = days[weekday-1]
        

    }
    
    

}
