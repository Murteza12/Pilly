//
//  ScheduleVC.swift
//  Pilly
//
//  Created by Murtaza on 22/04/2019.
//  Copyright © 2019 Murtaza. All rights reserved.
//

import UIKit
import DatePicker
class ScheduleVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var startDateLabel: UILabel!
    var mutidayselect:Bool = false
    var selectedDayArray:[String] = []
    @IBOutlet weak var allDaysLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    @IBOutlet weak var DaysTableView: UITableView!
    var DateSlect:String = ""
    @IBOutlet weak var freqValueLabel: UILabel!
    @IBOutlet weak var freqLabel: UILabel!
    
    let pickerData = ["Every Day", "Specific Day"]
    let DaysChoiceArray = ["Once a Day", "Twice a Day", "Three time a Day"]
    var alldays:String = ""
    
    var DayArray:[String] = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
    
    var toolBar = UIToolbar()
    var picker: UIPickerView = UIPickerView()
     var Daypicker: UIPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         picker.backgroundColor = .white
        picker.delegate = self
        picker.dataSource = self
        //value Label
        Daypicker.backgroundColor = .white
        Daypicker.delegate = self
        Daypicker.dataSource = self
        // Do any additional setup after loading the view.
        DaysTableView.delegate = self
        DaysTableView.dataSource = self
        self.DaysTableView.alpha = 0
        startDateLabel.text = self.convertDateFormater("\(Date())")
    }
    

    @IBAction func NeXtBtn(_ sender: Any) {
        if startDateLabel.text == ""{
            self.showToast(message: "Start Date Required")
        }else if endDateLabel.text == ""{
            self.showToast(message: "End Date Required")
        }else if freqLabel.text == ""{
            self.showToast(message: " Days Required")
        }else if allDaysLabel.text == ""{
            self.showToast(message: "No Days Required")
        }else{
            
            self.daysarryaload()
           
            UserDefaults.standard.set(startDateLabel.text, forKey: "sdate")
             UserDefaults.standard.set(endDateLabel.text, forKey: "edate")
             UserDefaults.standard.set(freqLabel.text, forKey: "frequency")
             UserDefaults.standard.set(allDaysLabel.text, forKey: "noinday")
             UserDefaults.standard.set(alldays, forKey: "daysvalue")
            UserDefaults.standard.set(DaysChoiceArray.count, forKey: "specficdaycount")
             //UserDefaults.standard.set(alldays, forKey: "specficdaycount")
             self.NextTransVC(Controllers: "RefillVC")
        }
        
        
    }
    
    func daysarryaload()
    {
        if mutidayselect{
        for i in DaysChoiceArray{
            alldays = "\(i) ,"
        }
        }
    }
    
    @IBAction func StartBtn(_ sender: UIButton) {
        self.datePickerTapped(sender: sender)
       
    }
    
    @IBAction func endDateBtn(_ sender: UIButton) {
        self.datePickerTapped(sender: sender)
        //self.endDateLabel.text = DateSlect
    }
    
    @IBAction func FrequencyBtn(_ sender: UIButton) {
        if sender.tag == 10{
            self.OpenPickerView(picker: Daypicker)
        }else if sender.tag == 11{
            self.OpenPickerView(picker: picker)
        }
        
        
    }
    
    
    func OpenPickerView(picker:UIPickerView){
        
        //picker = UIPickerView.init()
        picker.delegate = self
        picker.dataSource = self
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
        Daypicker.removeFromSuperview()
    }
   
    
    func datePickerTapped(sender:UIButton) {
        let calender = Calendar.current
        let date = Date()
        let finalDate = calender.date(byAdding: Calendar.Component.year, value: 10, to: date)
        let datePicker = DatePicker()
        datePicker.setup(min: Date(), max: finalDate!) { (selected, date) in
            if selected, let selectedDate = date {
                
                print("\(selectedDate)")
                
                //self.endDateLabel.text =  self.convertDateFormater("\(selectedDate)")
                
                self.DateSlect = self.convertDateFormater("\(selectedDate)")
                if sender.tag == 5{
                    self.startDateLabel.text = self.DateSlect
                }else if sender.tag == 6{
                    self.endDateLabel.text = self.DateSlect
                }
            } else {
                print("cancelled")
            }
        }
        datePicker.display(in: self)
    }

    
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return  dateFormatter.string(from: date!)
        
    }
    
    
    func NextTransVC(Controllers:String){
        let myMenu = self.storyboard?.instantiateViewController(withIdentifier: "\(Controllers)")
        myMenu!.hidesBottomBarWhenPushed = true
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.navigationController?.view?.layer.add(transition, forKey: nil)
        // self.navigationController?.pushViewController(myMenu, animated: false)
        myMenu?.modalPresentationStyle = .overCurrentContext
        navigationController?.pushViewController(myMenu!, animated: true)
        // present(myMenu!, animated: false, completion: nil)
        //self.NextViewController(storybordid: "SideMenuViewController")
    }
    
}
extension ScheduleVC{
    
    //print("button clickd")
    


func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
}



func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    var  count:Int = 0
    if pickerView == picker{
    count = pickerData.count
    }else if pickerView == Daypicker{
        count = DaysChoiceArray.count
    }
    return count
}

func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    //print("row valu is \(pickerData[row])")
    var pickValue:String = ""
    if pickerView == Daypicker{
        pickValue =  DaysChoiceArray[row]
    }else if pickerView == picker{
    pickValue =  pickerData[row]
    }
    return pickValue
}

func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
   
    
    
    if pickerView == picker{
         freqLabel.text = self.pickerData[row]
        freqValueLabel.text = self.pickerData[row]
    if freqLabel.text == "Specific Day"{
        mutidayselect = true
        self.DaysTableView.alpha = 1
    }else{
        mutidayselect = false
        self.DaysTableView.alpha = 0
    }
    }else if pickerView == Daypicker{
        allDaysLabel.text =  self.DaysChoiceArray[row]
    }
    
    self.view.endEditing(true)
}
    
    //Mark   Table view here
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DayArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = DayArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(self.coloursArray[indexPath.row])
        
        //alldays += self.DayArray[indexPath.row]+" ,"
        //self.allDaysLabel.text = "\(String(describing: alldays))"
       // slecvalue = true
       // self.DaysTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
       if let cell = self.DaysTableView.cellForRow(at: indexPath as IndexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                //checked[indexPath.row] = false
                selectedDayArray.removeAll { (value) -> Bool in
                 self.DayArray[indexPath.row] == value
                }
            } else {
                cell.accessoryType = .checkmark
                //checked[indexPath.row] = true
               self.DaysTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                 //selectedDayArray.remove(at: indexPath.row)
                selectedDayArray.append(self.DayArray[indexPath.row])
            }
        }
        
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        self.tableView.cellForRow(at: indexPath)?.accessoryType = .none
//    }
    
}
