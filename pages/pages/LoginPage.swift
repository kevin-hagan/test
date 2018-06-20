//
//  LoginPage.swift
//  pages
//
//  Created by Kevin Hagan on 6/12/18.
//  Copyright © 2018 Kevin Hagan. All rights reserved.
//

import UIKit
import SQLite3

class LoginPage: UIViewController {
    
    // Attributes
    
    var db: OpaquePointer?
    
    var thisUserID : Int = 0
    
    var validCredentials = false
    
    //var userNameInput : String = ""
    var userList = [User]()

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //database stuff
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("Users.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        readValues()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // buttons
    
    @IBAction func newUserButton(_ sender: Any) {
        
        performSegue(withIdentifier: "newUserSegue", sender: self)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        let input = userNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordInput = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        for person in userList {
            
            if person.userName == input && person.passWord == passwordInput{
                validCredentials = true
                
                thisUserID = person.id
                
                performSegue(withIdentifier: "login", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("PREPARE")
        let vc = segue.destination as! ViewController
        vc.userID = Int(thisUserID)
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
            
            print("userName: "+userName)
            print("password: "+passWord)
            print("points: "+String(points))
            
            
            
            //adding values to list
            userList.append(User(id: Int(id), userName: String(describing: userName), passWord: String(describing: passWord)))
            
            //print(userList[userList.count-1])
            
            
            //print(userList)
        }
        
    }
    
    
    
    
 /*   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("PREPARE")
        userName = userNameTextField.text!
        let vc = segue.destination as! ViewController
        vc.welcomeUserName = "Welcome "+userName+"!"
        print(vc.welcomeUserName)
    }*/
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
