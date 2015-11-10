//
//  ViewController.swift
//  Macys_Swift
//
//  Created by Ahmed Saleh on 11/9/15.
//  Copyright © 2015 Reefna. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    // holds the meanings of acronyms
    private var meanings: Array<AnyObject>? = Array() // init right away
    
    // MARK:- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Generic Methods
    func getAcronymMeanings(acronym:String) {
 
        Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["foo": "bar"])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
    }


    // MARK:- Button Actions
    @IBAction func searchButtonPressed(sender: AnyObject) {
        
        // hide keyboard
        self.textField.resignFirstResponder()
        
        // get and display the data
        getAcronymMeanings(self.textField.text!)
    }
    
    // MARK:- TableView Data Source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.meanings?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sampleCell")
        
        
        
        
        return cell!
    }
    
    
}

