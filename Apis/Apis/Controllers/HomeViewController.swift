//
//  HomeViewController.swift
//  Apis
//
//  Created by Francisco Castro on 10/13/19.
//  Copyright © 2019 Francisco Castro. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
        var fecha = Date()
       
    
    var movimiento: [Gasto] = []
    var boolIngreso: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        let loc = Locale(identifier: "es_MX")
        self.datePickerOutlet.locale = loc
        calcularTotales()
    }
    
    
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        fecha = sender.date
        let df = DateFormatter()
        df.dateStyle = .long
        df.timeStyle = .none
        
        if( df.string(from: fecha) != df.string(from: Date())){
            fondoImagen.isHidden=true
            cantidadParaHoy.isHidden=true
            labelCantidad.isHidden=true
        }
        else{
            fondoImagen.isHidden=false
            cantidadParaHoy.isHidden=false
            labelCantidad.isHidden=false
        }
        
    }
    
    
    @IBOutlet weak var fondoImagen: UIImageView!
    @IBOutlet weak var cantidadParaHoy: UILabel!
    @IBOutlet weak var labelCantidad: UILabel!
    
    
    @IBAction func agregarIngreso(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "Gastos") as! NuevoGastoViewController
        vc.ingreso = true
        vc.delegadoHome = self
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.show(vc, sender: self)
    }
    
    @IBAction func agregaGasto(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "Gastos") as! NuevoGastoViewController
        vc.gasto = true
        vc.delegadoHome = self
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.show(vc, sender: self)
    }
    
    
    @IBAction func btSettings(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "PantallaPrincipal") as! ViewController
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.show(vc, sender: self)
        
    }
    
    func dataFileUrl() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "ddMMyy"
        let str2 = df.string(from: date)
        var str = ""
        if boolIngreso {
            str = str2 + "ingreso" + ".plist"
        } else {
            str = str2 + "gasto" + ".plist"
        }
        
        return url.appendingPathComponent(str)
    }
    
    func guardar() {
        do {
            let data = try PropertyListEncoder().encode(self.movimiento)
            try data.write(to: dataFileUrl())
        }
        catch {
            print("Save Failed")
        }
    }
    
    func cargar() {
        do {
            let data = try Data.init(contentsOf: dataFileUrl())
            self.movimiento = try PropertyListDecoder().decode([Gasto].self, from: data)
        }
        catch {
            print("Error reading or decoding file")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let va = segue.destination as! GastosIngresosTableViewController
            va.fecha=fecha
    }
    
    
    func calcularTotales(){
        var cantidadADesplegar: Double!
        cantidadADesplegar = (UserDefaults.standard.value(forKey: "DineroActual")) as! Double
        cantidadADesplegar = (cantidadADesplegar/30.00)/24.00
        cantidadParaHoy.text! = String(format: "%.3f", cantidadADesplegar)
        
    }
    
    
}

extension HomeViewController: Movimiento{
    func agregaMovimiento(gasto: Gasto, boolIngreso: Bool) {
        self.boolIngreso = boolIngreso
        self.cargar()
        movimiento.append(gasto)
        guardar()
    }
}
