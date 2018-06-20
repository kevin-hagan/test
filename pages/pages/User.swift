//
//  User.swift
//  pages
//
//  Created by Kevin Hagan on 6/14/18.
//  Copyright © 2018 Kevin Hagan. All rights reserved.
//

class User {
    
    var id: Int
    var userName: String?
    var passWord: String?
    
    init(id: Int, userName: String?, passWord: String?){
        self.id = id
        self.userName = userName
        self.passWord = passWord
    }
}
