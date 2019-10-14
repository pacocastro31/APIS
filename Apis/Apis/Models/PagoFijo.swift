//
//  PagoFijo.swift
//  Apis
//
//  Created by Francisco Castro on 10/8/19.
//  Copyright © 2019 Francisco Castro. All rights reserved.
//

import UIKit

class PagoFijo: NSObject, Codable {
    
    var nombre: String!
    var cantidad: Double!
    var diaARecordar: Int!

    init(nombre: String, cantidad: Double, diaARecordar: Int) {
        self.nombre = nombre
        self.cantidad = cantidad
        self.diaARecordar = diaARecordar
    }
}
