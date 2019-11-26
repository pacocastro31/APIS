//
//  HomeViewController.swift
//  Apis
//
//  Created by Francisco Castro on 10/13/19.
//  Copyright © 2019 Francisco Castro. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func agregarIngreso(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "Gastos") as! NuevoGastoViewController
        vc.ingreso = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.show(vc, sender: self)
    }
    
    @IBAction func agregaGasto(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "Gastos") as! NuevoGastoViewController
        vc.gasto = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.show(vc, sender: self)
    }
    
    
    @IBAction func btSettings(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
               let vc = sb.instantiateViewController(identifier: "PantallaPrincipal") as! ViewController
               vc.modalPresentationStyle = .fullScreen
               self.navigationController?.show(vc, sender: self)
        
    }
    
}
