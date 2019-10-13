//
//  User.swift
//  Apis
//
//  Created by Francisco Castro on 10/8/19.
//  Copyright © 2019 Francisco Castro. All rights reserved.
//

import UIKit

class User: NSObject {
    
    static let shared = User()
    
    var name: String!
    var salary: Double!
    
    override init(){}
    
    func requestUser(){
        self.name = (UserDefaults.standard.value(forKey: "salary") as! String)
        self.salary = (UserDefaults.standard.value(forKey: "name") as! Double)
    }
    
}
