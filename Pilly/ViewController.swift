//
//  ViewController.swift
//  Pilly
//
//  Created by Murtaza on 18/04/2019.
//  Copyright © 2019 Murtaza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
   var nowTimes:String = "8:00"
//    var nowTime2:String = "14:00"
//     var nowTime3:String = "20:00"
    
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // self.scheduledTimerWithTimeInterval()
    }

    
    func scheduledTimerWithTimeInterval(){
       
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(updateCounting), userInfo: nil, repeats: true)
    }
    @objc func updateCounting(){
         print("Timer Exectuted..")
       print(self.currentTime())
        if self.currentTime() == nowTimes{
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

