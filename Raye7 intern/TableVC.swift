//
//  TableVC.swift
//  Raye7 intern
//
//  Created by Mohamed El Naggar on 6/7/17.
//  Copyright © 2017 Mohamed El Naggar. All rights reserved.
//

import UIKit

class TableVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Array of pairs (That i Will save Title and body from Server on it
    var recievedData = [(String , String)]()
    
    // indicate userID to call API for this user
    var currentUserID = 1 , lastUserID = 10 // I will download until current <= lastOne
    var isLoading: Bool = false // indicator while isLoading from Server or not
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load first 10 posts
        loadFromServer()
        
        /* -------- Table Configration -------- */
        
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // function load 10 by 10 Posts because Time of Recieving 100 posts might be LARGE
    fileprivate func loadFromServer() {
        guard currentUserID <= lastUserID else { return } // validate if i finish downlaoding all posts
        guard !isLoading else { return } // if call this func while i am loading rightnow

        isLoading = true
        API.getData(id: currentUserID) { (success, returnedData) in
            if success {
                // add returnedData --> RecievedData
                // Exactly Like Concatenation
                self.recievedData.append(contentsOf: returnedData!)
                
                // ReloadData tableView and Add returnedData to CustonCells
                self.tableView.reloadData()
                
                // Refer to Next userID to Load his posts next time
                self.currentUserID += 1
                self.isLoading = false // End Loading 10 posts from server
                // print(self.recievedData.count)
            } else {
                // Failed to Get Data from Server
                // We can Add Alert to User ( show 3 seconds and Disappear
                self.alertUser("Error" , "Error While Loading from Server")
            }
        }
    }
    
    
    // Alert Display on the Screen
    fileprivate func alertUser(_ title: String , _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // Add Alert to our ViewController
        self.present(alert, animated: true, completion: nil)
        
        // after (3 seconds) --> dismiss the Alert View
        DispatchQueue.main.asyncAfter(deadline: .now() + 3 ) {
            // dissmiss alert
            alert.dismiss(animated: true, completion: nil)
        }
    }
}


extension TableVC: UITableViewDataSource {
    // select number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // select number of Rows in Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recievedData.count
    }
    
    // Cell for each Row in Section
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // if you can assign it as CustomCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else { return UITableViewCell() }
        
        // set title and Text to Label and TextView
        cell.initializeCell(data: (recievedData[indexPath.row]))
        
        return cell
    }
    
}

extension TableVC: UITableViewDelegate {
    
    // if last Cell in TableView Will Display then Load Next 10 Posts from Server
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let currentPosts = recievedData.count
        //print("Load next 10 posts")
        
        if indexPath.row == currentPosts - 1 {
            // load next 10 posts and so on
            self.loadFromServer()
        }
    }
}
