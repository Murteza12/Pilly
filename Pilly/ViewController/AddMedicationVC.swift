//
//  AddMedicationVC.swift
//  Pilly
//
//  Created by Murtaza on 19/04/2019.
//  Copyright © 2019 Murtaza. All rights reserved.
//

import UIKit
import CoreData

protocol saveDosageQuanitiy {
   func didTapSave(dosage: String, dosageUnit: String)
}

class AddMedicationVC: UIViewController,selectedColorDelegate , saveDosageQuanitiy{
   
    
  
    //Dosage Varibale
    var dosage:String = ""
    var dosageUnit:String = ""
   //Sound VC
    var Soundname:String = "Default"
    
    @IBOutlet weak var medicineNamefield: UITextField!
    var seletedImg:UIImage?
    @IBOutlet weak var soundLabel: UILabel!
    @IBOutlet weak var totalPillsLabel: UILabel!
    
    var colorvc:ColorPhotoVC?
    @IBOutlet weak var colorImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        colorImageView.setImageColor(color: UIColor.blue)
        
        self.soundLabel.text = Soundname
        
       // self.FetchMedicineData()
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        //colorvc?.delegate = self
       
    }
    @IBAction func dosageBtn(_ sender: UIButton) {
//        self.NextTransVC(Controllers:"DosageVC")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DosageVC") as! DosageVC
        vc.saveDosageQuanitiyDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func colurBtn(_ sender: Any) {
       // self.NextTransVC(Controllers: "ColorPhotoVC")
        
        guard  let secondView = self.storyboard?.instantiateViewController(withIdentifier: "ColorPhotoVC") as? ColorPhotoVC else {
            fatalError("View Controller not found")
        }
        secondView.delegate = self
        //self.NextTransVC(Controllers: "ColorPhotoVC")
        //Protocol conformation here
        navigationController?.pushViewController(secondView, animated: true)
        
    }
    func sendvalue(value: String) {
        print("value is \(value)")
    }
    

    @IBAction func soundbtn(_ sender: UIButton) {
        self.NextTransVC(Controllers: "SelctSoudVC")
    }
    
    @IBAction func NextBtn(_ sender: Any) {
        
        if medicineNamefield.text == ""{
            self.showToast(message: "\(medicineNamefield.placeholder!) is required")
        }else if totalPillsLabel.text == ""{
            self.showToast(message: "Dosage Required")
        }else {
            UserDefaults.standard.set(medicineNamefield.text!, forKey: "dosage")
             UserDefaults.standard.set(totalPillsLabel.text!, forKey: "totalpills")
            if colorImageView.image == nil{
                UserDefaults.standard.set("\(String(describing: colorImageView.backgroundColor))", forKey: "color")
            }else{
                let imageData = colorImageView.image!.pngData()
               // UserDefaults.standard.setValue(, forKey: )
            UserDefaults.standard.set(colorImageView.image!, forKey: "colorimg")
            UserDefaults.standard.set(self.soundLabel.text, forKey: "sound")
                
            }
          self.NextTransVC(Controllers: "ScheduleVC")
            
        }
        
    }
    
    func didTapSave(dosage: String, dosageUnit: String) {
        self.totalPillsLabel.text = "\(dosage) \(dosageUnit)"
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
    
    func selectedColor(colorObj: Colours) {
        print("New Color is \(colorObj)")
        self.colorImageView.backgroundColor = colorObj.color
    }
    
    func selectedImage(image: UIImage) {
        self.colorImageView.image = image
    }
    
   
    
    
    
}
