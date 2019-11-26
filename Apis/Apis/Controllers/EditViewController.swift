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
    
    
    @IBAction func clickEdit(_ sender: UIBarButtonItem) {
        tfNombre.isEnabled=true
        tfCantidad.isEnabled=true
        tfDescripcion.isEditable=true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
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
