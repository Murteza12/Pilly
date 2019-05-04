//
//  SideMenuVC.swift
//  Pilly
//
//  Created by Murtaza on 19/04/2019.
//  Copyright © 2019 Murtaza. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit
class SideMenuVC: UIViewController ,MFMailComposeViewControllerDelegate{

    @IBOutlet var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hi there
        // Do any additional setup after loading the view.
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.leftSwiped))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.mainView.addGestureRecognizer(swipeLeft)
    }
    
    
    
    @objc func leftSwiped() {
        // handling code
        self.navigateBack()
        self.dismiss(animated: false, completion: nil)
    }
    func navigateBack(){
        
        //        dismiss(animated: false)
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        //self.navigationController?.popViewController(animated: false)
    }
    
   //rate
    func requestToRate() {
        SKStoreReviewController.requestReview()
        
    }
  
    
    
    @IBAction func HomeBtn(_ sender: Any) {
       // self.NextViewController(storybordid: "MedicationVC")
        
    }
    @IBAction func reminderBtn(_ sender: Any) {
        self.NextViewController(storybordid: "ReminderVC")
        
    }
    
    @IBAction func privacyBtn(_ sender: Any) {
         self.NextViewController(storybordid: "PrivacyVC")
    }
    
    @IBAction func contactBtn(_ sender: Any) {
         //self.NextViewController(storybordid: "")
        
        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            showMailError()
        }
    }
    
    @IBAction func shareBtn(_ sender: Any) {
       // self.Sharelink(message: "Share with Friends.")
        self.requestToRate()
    }
    
    func Sharelink(message:String)
    {
        
        let activitycontroller = UIActivityViewController(activityItems: ["\(message)"], applicationActivities: nil)
        present(activitycontroller, animated: true, completion:{ () in print("Done🔨")
            
        })
    }
    
    
    
   


func configureMailController() -> MFMailComposeViewController {
    let mailComposerVC = MFMailComposeViewController()
    mailComposerVC.mailComposeDelegate = self
    
    mailComposerVC.setToRecipients(["andrew@seemuapps.com"])
    mailComposerVC.setSubject("Hello")
    mailComposerVC.setMessageBody("How are you doing?", isHTML: false)
    
    return mailComposerVC
}

func showMailError() {
    let sendMailErrorAlert = UIAlertController(title: "Could not send email", message: "Your device could not send email", preferredStyle: .alert)
    let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
    sendMailErrorAlert.addAction(dismiss)
    self.present(sendMailErrorAlert, animated: true, completion: nil)
}

func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true, completion: nil)
}
    
}
