//
//  EditViewController.swift
//  Apis
//
//  Created by Martha Arnaud on 11/25/19.
//  Copyright © 2019 Francisco Castro. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfCantidad: UITextField!
    @IBOutlet weak var tfDescripcion: UITextView!
    
    @IBOutlet weak var btEdit: UIBarButtonItem!
    var fecha = Date()
    var boolEdit = false
    var arr: [Gasto] = []
    var movMostrar: Gasto!
    
    
    override func viewDidLoad() {
          super.viewDidLoad()
      
        tfNombre.text=String(movMostrar.nombre)
        tfCantidad.text=String(movMostrar.cantidad)
        tfDescripcion.text=String(movMostrar.description)
        
      }
      
    
        func dataFileUrl() -> URL {
          let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
            let df = DateFormatter()
            df.dateStyle
                = .short
            df.timeStyle = .none
            df.timeZone = .none
            let str = df.string(from:fecha)+"ingreso"+".plist"
         
          return url.appendingPathComponent(str)
      }
    
    
    
    @IBAction func clickEdit(_ sender: UIBarButtonItem) {
        boolEdit = !boolEdit
        
        if boolEdit {
         tfNombre.isEnabled=true
         tfCantidad.isEnabled=true
         tfDescripcion.isEditable=true
        let item = self.navigationItem.rightBarButtonItem!
            item.title = "Save"
        } else {
            tfNombre.isEnabled=false
            tfCantidad.isEnabled=false
            tfDescripcion.isEditable=false
            let item = self.navigationItem.rightBarButtonItem!
            item.title = "Edit"
            
            //algo para guardar el cambio
            do {
                let data = try PropertyListEncoder().encode(arr)
                try data.write(to: dataFileUrl())
             }
             catch {
                print("Save Failed")
             }
            
        }
    }
    
    @IBAction func obtenerRegistro(_ sender: UIButton) {
              // borro la lista para verificar que sí se obtengan
              arr.removeAll()
              
              do {
                  let data = try Data.init(contentsOf: dataFileUrl())
                  arr = try PropertyListDecoder().decode([Gasto].self, from: data)
              }
              catch {
                  print("Error reading or decoding file")
              }
    }
    
  
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
