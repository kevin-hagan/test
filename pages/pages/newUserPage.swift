//
//  newUserPage.swift
//  pages
//
//  Created by Kevin Hagan on 6/12/18.
//  Copyright © 2018 Kevin Hagan. All rights reserved.
//

import UIKit
import SQLite3

internal let SQLITE_STATIC = unsafeBitCast(0, to: sqlite3_destructor_type.self)
internal let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)


class newUserPage: UIViewController {
    
    var db: OpaquePointer?
    
    // text fields
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // database stuff
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDir = dirPaths[0].path
        print(docsDir)
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("Users.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS userTable (id INTEGER PRIMARY KEY AUTOINCREMENT, userName TEXT, passWord TEXT, points INTGEGER)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        
        
        // end database stuff
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createButton(_ sender: Any) {
        
        // get values from text fields
        
        let userName = userTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let passWord = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //print(userName!)
        //print(passWord!)
        
        //validating that values are not empty
        
        if(userName?.isEmpty)!{
            userTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        if(passWord?.isEmpty)!{
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        //creating a statement
        var stmt: OpaquePointer?
        
        
        //the insert query
        let queryString = "INSERT INTO userTable (userName, passWord, points) VALUES (?,?,0)"
        
        //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        
        
        //binding the parameters
        if sqlite3_bind_text(stmt, 1, userName, -1, SQLITE_TRANSIENT) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        //print("username: "+userName!)
        
        
        
        if sqlite3_bind_text(stmt, 2, passWord, -1, SQLITE_TRANSIENT) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        
        //print("password: "+passWord!)
        
        //executing the query to insert values
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting user: \(errmsg)")
            return
        }
       
        //emptying the textfields
        userTextField.text=""
        passwordTextField.text=""
        
        //readValues()
        
        
        //print(String(cString: sqlite3_column_text(stmt, 1)))
        //print(String(cString: sqlite3_column_text(stmt, 2)))
        
        //displaying a success message
        print("User saved successfully")
        
        
        
        //performSegue(withIdentifier: "createSegue", sender: self)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
