//
//  GastosIngresosTableViewController.swift
//  Apis
//
//  Created by Francisco Castro on 11/24/19.
//  Copyright © 2019 Francisco Castro. All rights reserved.
//

import UIKit

class GastosIngresosTableViewController: UITableViewController {
    
    var movimientos: [Gasto]!
    var ingreso: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.movimientos = cargar(str: "ingreso")
        for i in cargar(str: "gasto"){
            self.movimientos.append(i)
        }
        self.tableView.reloadData()
    }

    func dataFileUrl(str: String) -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "ddMMyy"
        
        let pathArchivo = url.appendingPathComponent(df.string(from: date) + str + ".list")
        return pathArchivo
    }
    
    
    func cargar(str: String) -> [Gasto] {
        do {
            let data = try Data.init(contentsOf: dataFileUrl(str: str))
            let gasto = try PropertyListDecoder().decode([Gasto].self, from: data)
            return gasto
        }
        catch {
            print("Error reading or decoding file")
        }
        return []
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
}
