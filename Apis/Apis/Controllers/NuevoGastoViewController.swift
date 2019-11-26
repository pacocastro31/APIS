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
    }
    
    func dataFileUrl() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let date = Date()
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .none
        df.timeZone = .none
        
        if ingreso ?? false{
            let str = df.string(from: date) + "ingreso" + ".plist"
            return url.appendingPathComponent(str)
        } else {
            let str = df.string(from: date) + "gasto" + ".plist"
            return url.appendingPathComponent(str)
        }
        
    }
    
    func guardar() {
        if ingreso ?? false{
            var arr = self.cargar()
            let ingreso = Gasto(nombre: self.nombre.text!, descripcion: self.descripcion.text!, cantidad: Double(self.cantidad.text!)!, ingreso: true)
            arr.insert(ingreso, at: arr.count)
            do {
                let data = try PropertyListEncoder().encode(arr)
                try data.write(to: dataFileUrl())
            }
            catch {
               print("Save Failed")
            }
        } else if gasto ?? false{
            var arr = self.cargar()
            let gasto = Gasto(nombre: self.nombre.text!, descripcion: self.descripcion.text!, cantidad: Double(self.cantidad.text!)!, ingreso: false)
            arr.insert(gasto, at: arr.count)
            do {
                let data = try PropertyListEncoder().encode(arr)
                try data.write(to: dataFileUrl())
            }
            catch {
               print("Save Failed")
            }
        }
    }
    
    func cargar() -> [Gasto] {
        do {
            let data = try Data.init(contentsOf: dataFileUrl())
            let gasto = try PropertyListDecoder().decode([Gasto].self, from: data)
            return gasto
        }
        catch {
            print("Error reading or decoding file")
        }
        return []
    }
    
    @IBAction func guardarPagoFijo(_ sender: Any) {
        if self.ingreso ?? false || self.gasto ?? false {
            self.guardar()
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
