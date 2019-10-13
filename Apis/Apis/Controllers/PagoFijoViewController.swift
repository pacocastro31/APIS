//
//  PagoFijoViewController.swift
//  Apis
//
//  Created by Francisco Castro on 10/8/19.
//  Copyright © 2019 Francisco Castro. All rights reserved.
//

import UIKit

class PagoFijoViewController: UIViewController {

    @IBOutlet weak var cantidad: UITextField!
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var pvDate: UIPickerView!
    let days = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pvDate.delegate = self
        self.pvDate.dataSource = self
        
    }
    
    @IBAction func savePagoFijo(_ sender: Any) {
        
    }
}

extension PagoFijoViewController: UIPickerViewDataSource, UIPickerViewDelegate{
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
