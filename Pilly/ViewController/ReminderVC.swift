//
//  ReminderVC.swift
//  Pilly
//
//  Created by Murtaza on 02/05/2019.
//  Copyright © 2019 Murtaza. All rights reserved.
//

import UIKit

var nowfrom = "reminder"
class ReminderVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource ,UITableViewDelegate,UITableViewDataSource{
    
    var datePickerIndexPath: IndexPath?
    
    let pickerData = ["Every Day", "Every Week", "Every Month"]
    @IBOutlet weak var intervalLabel: UILabel!
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var dosefield: UITextField!
    @IBOutlet weak var pillField: UITextField!
    @IBOutlet weak var notefield: UITextField!
    
    // var Itemsarray:[(name:String,value:String)] = []
    var inputTexts: [String] = ["Alert Time 1"]
    var inputDates: [Date] = []
    
    @IBOutlet weak var reminderTableView: UITableView! {
        didSet{
            reminderTableView.register(UINib(nibName: DateTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: DateTableViewCell.reuseIdentifier())
            reminderTableView.register(UINib(nibName: DatePickerTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: DatePickerTableViewCell.reuseIdentifier())
            reminderTableView.dataSource = self
            reminderTableView.delegate = self
        }
    }
    
    var toolBar = UIToolbar()
    var picker: UIPickerView = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addInitailValues()
        // Do any additional setup after loading the view.
        self.pillField.text = medname
        picker.backgroundColor = .white
        // self.Itemsarray.append((name: "Alert Time 1", value: ""))
        //picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pillBtn(_ sender: Any) {
        self.NextViewController(storybordid: "MedicationVC")
        
    }
    
 
    func addInitailValues() {
        inputDates = Array(repeating: Date(), count: inputTexts.count)
    }
    
    func indexPathToInsertDatePicker(indexPath: IndexPath) -> IndexPath {
        if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row < indexPath.row {
            return indexPath
        } else {
            return IndexPath(row: indexPath.row + 1, section: indexPath.section)
        }
    }
    
    @IBAction func addtimeBtn(_ sender: Any) {
        let item = "Alert Time \(self.inputTexts.count + 1)"
        
        reminderTableView.beginUpdates()
        inputTexts.append(item)
        inputDates.append(Date())
        let indexPath:IndexPath = IndexPath(row:(self.inputTexts.count - 1), section:0)
        reminderTableView.insertRows(at: [indexPath], with: .left)
        reminderTableView.endUpdates()
        
        print(inputTexts)
        
    }
    
    @IBAction func InterValBtn(_ sender: Any) {
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
    
}


extension  ReminderVC{
    
    //<----------------------------  Picker View  ----------------->
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
        intervalLabel.text = self.pickerData[row]
        self.view.endEditing(true)
    }
    
    //<----------------------- table View  delegate-------------------------->
    
    
}


extension ReminderVC {
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if datePickerIndexPath != nil {
            return inputTexts.count + 1
        } else {
            return inputTexts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if datePickerIndexPath == indexPath {
            let datePickerCell = tableView.dequeueReusableCell(withIdentifier: DatePickerTableViewCell.reuseIdentifier()) as! DatePickerTableViewCell
            datePickerCell.updateCell(date: inputDates[indexPath.row - 1], indexPath: indexPath)
            datePickerCell.delegate = self
            return datePickerCell
        } else {
            let dateCell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.reuseIdentifier()) as! DateTableViewCell
            dateCell.updateText(text: inputTexts[indexPath.row], date: inputDates[indexPath.row])
            return dateCell
        }
    }
    
    //<----------------------- table View  delegate-------------------------->
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row - 1 == indexPath.row {
            tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
            self.datePickerIndexPath = nil
        } else {
            if let datePickerIndexPath = datePickerIndexPath {
                tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
            }
            datePickerIndexPath = indexPathToInsertDatePicker(indexPath: indexPath)
            tableView.insertRows(at: [datePickerIndexPath!], with: .fade)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if datePickerIndexPath == indexPath {
            return DatePickerTableViewCell.cellHeight()
        } else {
            return DateTableViewCell.cellHeight()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row != 0{
            if (editingStyle == .delete) {
                
                self.inputTexts.remove(at: indexPath.row)
                self.reminderTableView.reloadData()
            }
            // handle delete (by removing the data from your array and updating the tableview)
        }
        
    }
}


extension ReminderVC: DatePickerDelegate {
    
    func didChangeDate(date: Date, indexPath: IndexPath) {
        inputDates[indexPath.row] = date
        reminderTableView.reloadRows(at: [indexPath], with: .none)
    }
    
}
