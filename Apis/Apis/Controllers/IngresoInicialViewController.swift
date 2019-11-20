//
//  ViewController.swift
//  Apis
//
//  Created by Francisco Castro on 10/8/19.
//  Copyright © 2019 Francisco Castro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var salario: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let salario = UserDefaults.standard.value(forKey: "Salario"), let nombre = UserDefaults.standard.value(forKey: "Nombre") as? String {
            self.salario.text = "\(salario)"
            self.nombre.text = nombre
        }
        
    }
    
    @IBAction func registraPagosFijos(_ sender: UIButton) {
        guard let salario = Double(self.salario.text!), let nombre = self.nombre.text else {
            //mostrar alerta
            return
        }
        
        UserDefaults.standard.set(salario, forKey: "Salario")
        UserDefaults.standard.set(nombre, forKey: "Nombre")
    }
}

