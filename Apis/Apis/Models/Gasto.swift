//
//  Gasto.swift
//  Apis
//
//  Created by Francisco Castro on 11/24/19.
//  Copyright © 2019 Francisco Castro. All rights reserved.
//

import UIKit

class Gasto: NSObject, Codable {
    var nombre: String!
    var descripcion: String?
    var cantidad: Double!
    var ingreso: Bool!
    init(nombre: String, descripcion: String, cantidad: Double, ingreso: Bool) {
        self.nombre = nombre
        self.descripcion = descripcion
        self.cantidad = cantidad
        self.ingreso = ingreso
    }
}
