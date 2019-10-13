//
//  PagoFijo.swift
//  Apis
//
//  Created by Francisco Castro on 10/8/19.
//  Copyright © 2019 Francisco Castro. All rights reserved.
//

import UIKit

class PagoFijo: NSObject {
    
    var name: String!
    var account: Double!
    var dayToRemember: Int!

    init(name: String, account: Double, dayToRemember: Int) {
        self.name = name
        self.account = account
        self.dayToRemember = dayToRemember
    }
}
