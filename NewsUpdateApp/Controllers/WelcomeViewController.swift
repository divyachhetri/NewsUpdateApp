//
//  WelcomeViewController.swift
//  NewsUpdateApp
//
//  Created by Divya Pandit Chhetri on 6/13/18.
//  Copyright © 2018 Divya Pandit Chhetri. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let vc = UIStoryboard(name: "TopStories", bundle: nil).instantiateViewController(withIdentifier: "HeadlinesViewController") as! HeadlinesViewController
    let data = NewsSources()
    var CallAPI : AlamofireAPI?
    var reachability : Reachability!
    var internetConnection = false
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var weekDayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reachability = Reachability.init()
        //checkInternetConnection ()
        tableView.dataSource = self
        tableView.delegate = self
        updateDate()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkInternetConnection ()
    }
//    override func viewDidAppear(_ animated: Bool) {
//        checkInternetConnection()
//    }
    
    
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
        if internetConnection == true {
            let id = data.newsSourceId[indexPath.row]
        vc.sourceId = id
        CallAPI = AlamofireAPI(sourceId: id)
        callApi()
        } else {
            displayAlert()
        }

    }
    
    
    @IBAction func skipbuttonPressed(_ sender: UIButton) {
        if internetConnection == true {
            vc.sourceId = "Skip"
            CallAPI = AlamofireAPI(sourceId: "Skip")
            callApi()
            
        } else {
            displayAlert()
        }
        
        
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
    func callApi() {
        CallAPI?.getData() { (response, error) in
            if let data = response {
                self.vc.getJson = data
                self.navigationController?.pushViewController(self.vc, animated: true)
            }
            else {
                print("\(error!)")
            }
        }
   
    }
    func checkInternetConnection () {
        if ((self.reachability!.connection) != .none) {
            
            internetConnection = true
        } else {
            internetConnection = false
            displayAlert()
        }

    }
    func displayAlert () {
        let alert = UIAlertController(title: "No Internet Connection", message: "Check your internet connection and try again.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
    


