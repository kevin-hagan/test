//
//  ViewController.swift
//  pages
//
//  Created by Kevin Hagan on 5/31/18.
//  Copyright © 2018 Kevin Hagan. All rights reserved.
//

import UIKit
import SQLite3

class ViewController: UIViewController {

    // Attributes
    
    var pointsDisplay : Int = 0
    
    var db: OpaquePointer?
    
    var userList = [User]()
    
    var userID : Int = 0
    
    //var welcomeUserName : String = ""
    
    @IBOutlet weak var header: UILabel!
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //database stuff
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("Users.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        readValues()
        
        pointsLabel.text = String(pointsDisplay)
        welcomeLabel.text = String(userID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // Actions
    
    
    @IBAction func button(_ sender: UIButton) {
        
        //UPDATE userTable SET  points = replace(points, '0.0.0.0', '1.1.1.1');
        
        
        
        pointsDisplay = pointsDisplay + 1
        print(pointsDisplay)
        pointsLabel.text = String(pointsDisplay)
        
        //performSegue(withIdentifier: "right", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! page2
        vc.labelText = String(self.pointsDisplay)
    }
    
    func readValues(){
        
        //first empty the list of heroes
        userList.removeAll()
        
        //this is our select query
        let queryString = "SELECT * FROM userTable"
        
        //statement pointer
        var stmt:OpaquePointer?
        
        //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        //traversing through all the records
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            let userName = String(cString: sqlite3_column_text(stmt, 1))
            let passWord = String(cString: sqlite3_column_text(stmt, 2))
            let points = sqlite3_column_int(stmt, 3)
            
            if id == userID {
                pointsDisplay = Int(points)
            }
            
            //print("userName: "+userName)
            //print("password: "+passWord)
            //print("points: "+String(points))
            
            //adding values to list
            userList.append(User(id: Int(id), userName: String(describing: userName), passWord: String(describing: passWord)))
            
            //print(userList[userList.count-1])
            
            
            //print(userList)
        }
        
    }
    
}

