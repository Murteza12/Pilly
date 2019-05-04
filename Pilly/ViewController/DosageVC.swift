//
//  DosageVC.swift
//  Pilly
//
//  Created by Murtaza on 20/04/2019.
//  Copyright © 2019 Murtaza. All rights reserved.
//

import UIKit

class DosageVC: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate  {
   
    @IBOutlet weak var dosageField: UITextField!
    @IBOutlet weak var PickerLabel: UILabel!
    
    var saveDosageQuanitiyDelegate: saveDosageQuanitiy!
    
    let pickerData = ["Pills", "mg", "gr","Drops","pieces", "puffs", "unit","Teaspone","Patch"]
    var toolBar = UIToolbar()
    var picker: UIPickerView = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        picker.backgroundColor = .white
        
        //picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
    }
    

    
    @IBAction func SaveBtn(_ sender: Any) {
        if  dosageField.text == ""{
            self.showToast(message: "Select a Dosage")
        }else if PickerLabel.text == ""{
            self.showToast(message: "Select a Type")
        }else{
              self.navigationController?.popViewController(animated: true)
            let tempDosage = self.dosageField.text!
            let tempDosageUnit = self.PickerLabel.text!
            saveDosageQuanitiyDelegate.didTapSave(dosage: tempDosage, dosageUnit: tempDosageUnit)
        }
        
    }
    
    
    @IBAction func CloseBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
  
    
    
    @IBAction func DUnitBtn(_ sender: UIButton) {
        print("button clickd")
        
        picker = UIPickerView.init()
        self.picker.delegate = self
        self.picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.barTintColor = .red
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        
        self.view.addSubview(toolBar)
        
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
   
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("row valu is \(pickerData[row])")
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        PickerLabel.text = self.pickerData[row]
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Dosage" {
           if let nextViewController = segue.destination as? AddMedicationVC {
            
            nextViewController.dosage = self.dosageField.text!
            nextViewController.dosageUnit = self.PickerLabel.text!
            
        }
    }

}

}
