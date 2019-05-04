//
//  MedicationVC.swift
//  Pilly
//
//  Created by Murtaza on 18/04/2019.
//  Copyright © 2019 Murtaza. All rights reserved.
//

import UIKit
import CoreData
var medname:String = ""
class MedicationVC: UIViewController ,UITableViewDelegate,UITableViewDataSource{
   
    // new
    var nowTime:String = "8:00"
    var nowTime2:String = "14:00"
    var nowTime3:String = "20:00"
    
    // asdhflas;
    var timer = Timer()
    
    var once:Bool = false
    var twice:Bool = false
    var thrice:Bool = false
    
    @IBOutlet weak var medTableView: UITableView!
      var manageObjectContext: NSManagedObjectContext!
    
    var localobjectArray = [GlobalMedObj]()
    var localobj = GlobalMedObj()
    var medArray = [PillyMedcine]()
    
    var  currntTime:String = ""
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currntTime = currentTime()
        // Do any additional setup after loading the view.
         manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.FetchMedicineData()
        self.loadSaveData()
        self.scheduledTimerWithTimeInterval()
        self.CheckNotificationTime()
        
        
    }
    

    
    
    func CheckNotificationTime(){
        if once == true{
            if  self.nowTime == self.currntTime {
                self.appDelegate?.scheduleNotification(notificationType: "Take Your Pills")
            }
        }else if twice == true{
            if  self.nowTime == self.currntTime {
                self.appDelegate?.scheduleNotification(notificationType: "Take Your Pills")
            }else if self.nowTime2 == self.currntTime{
                self.appDelegate?.scheduleNotification(notificationType: "Take Your Pills")
            }
            
        }else if thrice == true{
            if  self.nowTime == self.currntTime {
                self.appDelegate?.scheduleNotification(notificationType: "Take Your Pills")
            }else if self.nowTime2 == self.currntTime{
                self.appDelegate?.scheduleNotification(notificationType: "Take Your Pills")
            }else if self.nowTime3 == self.currntTime{
                self.appDelegate?.scheduleNotification(notificationType: "Take Your Pills")
            }
        }
        
    }
    
    @IBAction func menuBtn(_ sender: Any) {
        self.showMenu()
        
    }
    
 func showMenu(){
        let myMenu = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
        myMenu.hidesBottomBarWhenPushed = true
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.navigationController?.view?.layer.add(transition, forKey: nil)
        // self.navigationController?.pushViewController(myMenu, animated: false)
        myMenu.modalPresentationStyle = .overCurrentContext
        present(myMenu, animated: false, completion: nil)
        //self.NextViewController(storybordid: "SideMenuViewController")
    }
    
    
    func FetchMedicineData() {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PillyMedcine")
        //let predicate = NSPredicate(format: "email = %@", self.email)
        
        //fetchRequest.predicate = predicate
        //
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
              
                localobj.color = data.value(forKey: "colour") as? String
                localobj.daysvalue = data.value(forKey: "daysvalues") as? String
                
                localobj.dosage = data.value(forKey: "dosage") as? String
                let edate = data.value(forKey: "enddate") as! Date
                
                localobj.endate = "\(edate)"
                
                localobj.frequency = data.value(forKey: "frequency") as? String
                
                localobj.medname = data.value(forKey: "medname") as? String
                
                localobj.noindays = data.value(forKey: "noindays") as? String
                
                localobj.photo = data.value(forKey: "photo") as? Data
                
                
                localobj.pilleft = data.value(forKey: "pilleft") as? String
                
                localobj.remider = data.value(forKey: "reminder") as? String
                
                localobj.rmtime = data.value(forKey: "rmtime") as? String
                
                let sdate = data.value(forKey: "sdate") as! Date
                
                localobj.sdate = "\(sdate)"
                
                localobj.sound = data.value(forKey: "sound") as? String
                localobj.specficdaycount = data.value(forKey: "specficdaycount") as? Int
                
                print("All data is \(data)")
                
                let Enddate:Date =  (localobj.endate?.toLargeDate())!
                print("End date is: \(self.comaparedate(endateDate: Enddate))")
                if self .comaparedate(endateDate: Enddate){
                    self.checkTimeCounter(value: localobj.noindays!)
                }
                
              //  print("colour is \(colour) daysvalues is \(daysvalues) ")
                
                print("All result is \(result)")
                localobjectArray.append(localobj)
                
                
            }
            print("All object array \(localobjectArray)")
            DispatchQueue.main.async {
                            self.medTableView.delegate = self
                             self.medTableView.dataSource = self
                              self.medTableView.reloadData()
            }
            
            
            
        } catch {
            self.alertMessageShow(title: "Faild", msg: "No Record found")
            print("Failed")
        }
    }
    
    // Check time counter
    func checkTimeCounter(value:String){
        
        if value == "Once a Day"{
            self.once = true
        }else if value == "Twice a Day"{
            
            self.twice = true
        }else if value == "Three time a Day"{
            self.thrice = true
            
        }
        
        print("Once is \(once) twice is \(twice) thrice is \(thrice)")
    }
    
}


// let DaysChoiceArray = ["Once a Day", "Twice a Day", "Three time a Day"]



extension MedicationVC{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.localobjectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = medTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MedTableViewCell
        cell.mednameLabel.text = self.localobjectArray[indexPath.row].dosage
        cell.dosagelabel.text = self.localobjectArray[indexPath.row].medname
         cell.timeLabel.text = self.localobjectArray[indexPath.row].noindays
        
        if self.localobjectArray[indexPath.row].photo == nil {
            //do stuff
            cell.imageView?.backgroundColor = self.localobjectArray[indexPath.row].color as? UIColor
            
        } else {
            //handle case where the variable is nil
           // imageView.image =
            cell.imageView?.image = UIImage(data: self.localobjectArray[indexPath.row].photo as! Data)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        var numOfSections: Int = 0
        if self.medArray.count > 0
        {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No  Medicine available.Press + to add New Pills "
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            //We need to create a context from this container
            // let mov = Movies[indexPath.row]
            let dosage = self.localobjectArray[indexPath.row].dosage
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PillyMedcine")
            let predicate = NSPredicate(format: "dosage = %@", dosage!)
            fetchRequest.predicate = predicate
            print("Total is \(localobjectArray.count)")
            //  managedContext.delete(mov)
            localobjectArray.remove(at: indexPath.row)
            managedContext.delete(medArray[indexPath.row])
            self.medTableView.reloadData()
            do {
                try managedContext.save()
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        self.loadSaveData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if nowfrom == "reminder"{
            medname = self.medArray[indexPath.row].dosage!
            self.NextViewController(storybordid: "ReminderVC")
        }
    }
    
    func loadSaveData()  {
        
        let eventRequest: NSFetchRequest<PillyMedcine> = PillyMedcine.fetchRequest()
        do{
            medArray  = try manageObjectContext.fetch(eventRequest)
            
            self.medTableView.reloadData()
            
        }catch
        {
            print("Could not load save data: \(error.localizedDescription)")
        }
    }
    
    // Time View
    
    
    func scheduledTimerWithTimeInterval(){
        
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(updateCounting), userInfo: nil, repeats: true)
    }
    @objc func updateCounting(){
        print("Timer Exectuted..")
        print(self.currentTime())
        if self.currentTime() == nowTime{
            print("okaya  equal ")
        }else{
            print("not equal")
        }
    }
    func currentTime()->String{
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: date)
        let hour = components.hour
        let minutes = components.minute
        //let second = components.second
        let  nowTime = "\(hour!):\(minutes!)"
        return nowTime
        // print("\(String(describing: hour!)):\(minutes!):\(second!)")
    }
    
}


extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.backgroundColor = color
    }
}
