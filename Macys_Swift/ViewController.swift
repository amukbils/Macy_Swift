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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // holds the meanings of acronyms
    private var meanings: Array<AnyObject>! {
        
        // update tableview everytime this gets set
        didSet {
            self.tableView.reloadData()
        }
    }// init right away
    
    // MARK:- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  init the tableview
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // init the meanings array
        self.meanings = Array()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Generic Methods
    func getAcronymMeanings(acronym:String) {
 
        Alamofire.request(.GET, "http://www.nactem.ac.uk/software/acromine/dictionary.py", parameters: ["sf": acronym])
            .responseJSON { response in
                
                // get the json
                if let JSON = response.result.value {
                    //print("JSON: \(JSON)")
                    self.meanings = JSON.firstObject!!.objectForKey("lfs") as! Array
                    //print("meanings: ", self.meanings)
                    
                    // hide the activity indicator
                    self.activityIndicator.stopAnimating()
                }
        }
    }


    // MARK:- Button Actions
    @IBAction func searchButtonPressed(sender: AnyObject) {
        
        // start the spinner
        self.activityIndicator.startAnimating()
        
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
        
        let text = self.meanings[indexPath.row] as! NSDictionary
        
        // update title
        cell?.textLabel!.text = text.objectForKey("lf") as? String
        
        //print("Cell Text: ", cell?.textLabel?.text)
        
        return cell!
    }
    
    // MARK:- TableView Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
}

