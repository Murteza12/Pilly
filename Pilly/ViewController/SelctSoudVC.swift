//
//  SelctSoudVC.swift
//  Pilly
//
//  Created by Murtaza on 23/04/2019.
//  Copyright © 2019 Murtaza. All rights reserved.
//

import UIKit

class SelctSoudVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var slecvalue:Bool = false
    var soundArray:[String] = ["abc","bcd"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    

    @IBAction func saveBtn(_ sender: Any) {
        if self.slecvalue == false{
            self.showToast(message: "Please Selcet Value")
        }else{
              self.navigationController?.popViewController(animated: true)
            performSegue(withIdentifier: "sound", sender: self)
           
        }
        
        
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension SelctSoudVC{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soundArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = soundArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(self.coloursArray[indexPath.row])
        
       slecvalue = true
        self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    
  //  let indexpath = self.newsTableView.indexPathForSelectedRow
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sound" {
            if let nextViewController = segue.destination as? AddMedicationVC {
                let indexpath = self.tableView.indexPathForSelectedRow
                
                ///nextViewController.dosage = self.dosageField.text!
                nextViewController.Soundname = soundArray[(indexpath?.row)!]
                
                
                
            }
        }
        
    }
    
}
