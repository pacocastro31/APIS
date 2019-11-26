//
//  GastosFijosViewController.swift
//  Apis
//
//  Created by Francisco Castro on 10/13/19.
//  Copyright © 2019 Francisco Castro. All rights reserved.
//

import UIKit

class GastosFijosViewController: UIViewController{
    
    var pagosFijosLista: [PagoFijo] = []
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.dataSource = self
        self.tableview.delegate = self
        
        self.cargar()
        //cargar pagos fijos guardados
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.guardar()
    }
    
    @IBAction func ContinuarHome(_ sender: UIButton) {
        self.guardar()
        
        UserDefaults.standard.setValue(true, forKey: "primeraPantalla")
        
        let sb = UIStoryboard(name: "Home", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "Home")
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! NuevoGastoViewController
        vc.delegado = self
    }
    
    func dataFileUrl() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent("GastosFijos.plist")
        return pathArchivo
    }
    
    func guardar() {
        do {
            let data = try PropertyListEncoder().encode(self.pagosFijosLista)
           try data.write(to: dataFileUrl())
        }
        catch {
           print("Save Failed")
        }
    }
    
    func cargar() {
        do {
            let data = try Data.init(contentsOf: dataFileUrl())
            self.pagosFijosLista = try PropertyListDecoder().decode([PagoFijo].self, from: data)
            self.tableview.reloadData()
        }
        catch {
            print("Error reading or decoding file")
        }
    }
}

extension GastosFijosViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.pagosFijosLista.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = self.pagosFijosLista[indexPath.row].nombre
        cell.detailTextLabel?.text = "$ \(self.pagosFijosLista[indexPath.row].cantidad!)"
        return cell
    }
}

extension GastosFijosViewController: PagoFijoProtocol {
    func guardarPago(pagoFijo: PagoFijo) {
        self.pagosFijosLista.append(pagoFijo)
        self.tableview.reloadData()
    }
}
