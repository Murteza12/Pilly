//
//  RefillVC.swift
//  Pilly
//
//  Created by Murtaza on 19/04/2019.
//  Copyright © 2019 Murtaza. All rights reserved.
//

import UIKit
import CoreData
struct GlobalMedObj{
    
    var color:String?
    var daysvalue:String?
    var dosage:String?
    var dosagevalue:String?
    var endate:String?
    var  frequency:String?
    var medname:String?
    var noindays:String?
    var photo:Data?
    var pilleft:String?
    var remider:String?
    var sdate:String?
    var sound:String?
   var specficdaycount:Int?
    var rmtime:String?
    
    
}



class RefillVC: UIViewController,UITextFieldDelegate {
    let timePicker = UIDatePicker()
    @IBOutlet weak var RemindField: UITextField!
    @IBOutlet weak var pillLeftField: UITextField!
    @IBOutlet weak var FillSwitich: UISwitch!
    
    var localobj = GlobalMedObj()
    var reminder:String = ""
    var refiltime:String = ""
    var refilremind:Bool = false
    @IBOutlet weak var SitchView: UIView!
    @IBOutlet weak var refilField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationItem.title = "Refill Reminder"
        //refilField.inputView = timePicker
        refilField.delegate = self
    }

    
//    UserDefaults.standard.set(startDateLabel.text, forKey: "sdate")
//    UserDefaults.standard.set(endDateLabel.text, forKey: "edate")
//    UserDefaults.standard.set(freqLabel.text, forKey: "frequency")
//    UserDefaults.standard.set(allDaysLabel.text, forKey: "noinday")
//    UserDefaults.standard.set(alldays, forKey: "daysvalue")
//    UserDefaults.standard.set(DaysChoiceArray.count, forKey: "specficdaycount")
    
    
    func PopulateData() ->Bool{
        
        localobj.dosagevalue = UserDefaults.standard.string(forKey: "totalpills")
        localobj.color = UserDefaults.standard.string(forKey: "color")
         localobj.photo = UserDefaults.standard.data(forKey: "colorimg")
        localobj.dosage = UserDefaults.standard.string(forKey: "dosage")
        localobj.sound = UserDefaults.standard.string(forKey: "sound")
         //localobj. = UserDefaults.standard.string(forKey: "dosage")
        
        localobj.sdate = UserDefaults.standard.string(forKey: "sdate")
        localobj.endate = UserDefaults.standard.string(forKey: "edate")
        localobj.frequency = UserDefaults.standard.string(forKey: "frequency")
        
        localobj.noindays = UserDefaults.standard.string(forKey: "noinday")
        localobj.daysvalue = UserDefaults.standard.string(forKey: "daysvalue")
         localobj.specficdaycount = UserDefaults.standard.integer(forKey: "specficdaycount")
        //localobj.specficdaycount = UserDefaults.standard.integer(forKey: "specficdaycount")
        
       
        localobj.pilleft = pillLeftField.text!
        localobj.remider = reminder
        localobj.rmtime = refiltime

        
        
        return true
        
    }
    
    
    
    
    
    
    @IBAction func SaveBtn(_ sender: Any) {
        if pillLeftField.text == ""{
            self.showToast(message: "\(pillLeftField.placeholder ?? "pillLeft") required")
        }else{
            if refilremind == false{
                reminder = "5"
                refiltime = "11:00 AM"
            }else{
                reminder =  RemindField.text!
                refiltime = refilField.text!
            }
            if   self.PopulateData() {
                self.AddMEdicineData()
            }
            
            
            
        }
        
        
    }
    
    
    
    // Add Movies
    
    func AddMEdicineData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "PillyMedcine", in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
        
        let Meddata = NSManagedObject(entity: userEntity, insertInto: managedContext)
//        let Rating:NSNumber = Int(self.RatingField.text!)! as NSNumber
//        user.setValue("\(self.email)", forKeyPath: "email")
       
         Meddata.setValue(localobj.color, forKey: "colour")
        
        Meddata.setValue(localobj.daysvalue, forKey: "daysvalues")
        Meddata.setValue(localobj.dosage, forKey: "dosage")
        
        Meddata.setValue(localobj.endate!.toDate(), forKey: "enddate")
        Meddata.setValue(localobj.frequency, forKey: "frequency")
        
        Meddata.setValue(localobj.dosagevalue, forKey: "medname")
        Meddata.setValue(localobj.noindays, forKey: "noindays")
        
       /// Meddata.setValue(localobj.medname, forKey: "medname")
        //Meddata.setValue(localobj.noindays, forKey: "noindays")
        
        //let imgdata = (ImageView?.image)!.pngData()
        
        Meddata.setValue(localobj.photo, forKey: "photo")
        Meddata.setValue(localobj.pilleft, forKey: "pilleft")
        //Meddata.setValue(localobj.remider, forKey: "reminder")
          Meddata.setValue(localobj.remider, forKey: "reminder")
          Meddata.setValue(localobj.rmtime, forKey: "rmtime")
        
         Meddata.setValue(localobj.sdate!.toDate(), forKey: "sdate")
        Meddata.setValue(localobj.sound, forKey: "sound")
        Meddata.setValue(localobj.specficdaycount, forKey: "specficdaycount")
        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
            self.showToast(message: "Pills  Added")
           // self.ClearFieds()
        } catch let error as NSError {
            self.showToast(message: " Failed")
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if refilField.text!.isEmpty {
            let formatter = DateFormatter()
            //.dateStyle = .medium
            formatter.timeStyle = .medium
            refilField.text = formatter.string(from: Date())
        }
        return true
    }
    
    @IBAction func ValueChageSwitch(_ sender: Any) {
        if FillSwitich.isOn {
           self.SitchView.alpha = 1
        } else {
           // textLabel.text = "The Switch is On"
            self.SitchView.alpha = 0
            //FillSwitich.setOn(true, animated:true)
        }
        
    }
    
    
    
            @IBAction func timeField(_ sender: UITextField) {
                //let datePickerView:UIDatePicker = UIDatePicker()
                
                timePicker.datePickerMode = .time
                
                sender.inputView = timePicker
                
                timePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
                
                
            }
    
            @objc func datePickerValueChanged(sender:UIDatePicker) {
                
                let dateFormatter = DateFormatter()
                
               // dateFormatter.dateStyle = dateFormatter.timeStyle
                
                dateFormatter.dateStyle = .none
                dateFormatter.timeStyle = .short
                
                refilField.text = dateFormatter.string(from: sender.date)
                self.view.endEditing(true)
            }

}
extension String {
    
    func toDate(withFormat format: String = "MM-dd-yyyy")-> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        
        return date
        
    }
 
    
    func toLargeDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss z")-> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        
        
        return date
        
    }
    
    
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
//    let date = dateFormatter.date(from: date)
//    dateFormatter.dateFormat = "MM-dd-yyyy"
}
