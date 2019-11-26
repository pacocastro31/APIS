//
//  PagoFijoViewController.swift
//  Apis
//
//  Created by Francisco Castro on 10/8/19.
//  Copyright © 2019 Francisco Castro. All rights reserved.
//

import UIKit

class NuevoGastoViewController: UIViewController {

    @IBOutlet weak var descripcion: UITextField!
    @IBOutlet weak var cantidad: UITextField!
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var pvDate: UIPickerView!
    
    
    var gasto: Bool?
    var ingreso: Bool?
    
    @IBOutlet weak var diaLabel: UILabel!
    
    var delegado: PagoFijoProtocol!
    var delegadoHome: Movimiento!
    
    let days = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pvDate.delegate = self
        self.pvDate.dataSource = self
        
        if self.gasto ?? false || self.ingreso ?? false {
            self.pvDate.isHidden = true
            self.diaLabel.isHidden = true
        }
        
        if self.ingreso ?? false {
            //HACER COSAS DE LOS GASTOS
            self.title = "Agrega ingreso"
        }
        
        if self.gasto ?? false {
            self.title = "Agrega gasto"
        }
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func guardarPagoFijo(_ sender: Any) {
        if self.ingreso ?? false || self.gasto ?? false {
            var bool: Bool = false
            if ingreso ?? false {
                bool = true
            }
            let df = DateFormatter()
            df.locale = Locale(identifier: "es_MX")
            df.dateStyle = .long
            df.timeStyle = .short
            let mov = Gasto(nombre: self.nombre.text!, descripcion: self.descripcion.text!, cantidad: Double(self.cantidad.text!)!, ingreso: bool, strDate: df.string(from: Date()) )
            
            self.delegadoHome.agregaMovimiento(gasto: mov, boolIngreso: bool)
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        guard let nombre = self.nombre.text, let cantidad = self.cantidad.text else {
            //mostrar alerta
            return
        }
        
        let pagofijo = PagoFijo(nombre: nombre, cantidad: Double(cantidad)!, diaARecordar: self.pvDate.hashValue + 1)
        
        self.delegado.guardarPago(pagoFijo: pagofijo)
        self.navigationController?.popViewController(animated: true)
    }
}

extension NuevoGastoViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.days.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(self.days[row])
    }
}

protocol PagoFijoProtocol {
    func guardarPago( pagoFijo: PagoFijo)
}

protocol Movimiento {
    func agregaMovimiento(gasto: Gasto, boolIngreso: Bool)
}
