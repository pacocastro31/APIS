//
//  GastosIngresosTableViewController.swift
//  Apis
//
//  Created by Francisco Castro on 11/24/19.
//  Copyright © 2019 Francisco Castro. All rights reserved.
//

import UIKit

class GastosIngresosTableViewController: UITableViewController {
    var fecha = Date()

    var movimientos: [Gasto]!
    var ingreso: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        let dateformat = DateFormatter()
        dateformat.dateFormat = "MM/dd/yyyy"
        self.title = dateformat.string(from: fecha)
        cargar()
        self.tableView.reloadData()
    }

    func dataFileUrl(boolIngreso: Bool) -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
      
        let df = DateFormatter()
        df.dateFormat = "ddMMyy"
        df.dateFormat = "ddMMyy"
        let str2 = df.string(from: fecha)
        var str = ""
        if boolIngreso{
            str = str2 + "ingreso" + ".plist"
        } else {
            str = str2 + "gasto" + ".plist"
        }
        
        return url.appendingPathComponent(str)
    }
    
    
    func cargar(){
        do {
            var data = try Data.init(contentsOf: dataFileUrl(boolIngreso: true))
            movimientos = try PropertyListDecoder().decode([Gasto].self, from: data)
            data = try Data.init(contentsOf: dataFileUrl(boolIngreso: false))
            for i in try PropertyListDecoder().decode([Gasto].self, from: data){
                
                movimientos.append(i)
            }
            
            
        }
        catch {
            print("Error reading or decoding file")
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.movimientos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = movimientos[indexPath.row].nombre
        cell.detailTextLabel?.text = String(movimientos[indexPath.row].cantidad)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! EditViewController
        vc.fecha=fecha
    }
}



