//
//  PrivacyVC.swift
//  Pilly
//
//  Created by Murtaza on 02/05/2019.
//  Copyright © 2019 Murtaza. All rights reserved.
//

import UIKit

class PrivacyVC: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    
    @IBOutlet weak var privacyTableView: UITableView!
    var PrivacyArray:[(title:String,description:String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        PrivacyArray.append((title: "Privacy", description: "MtSolutions built the ChinaIITax app as a free app. This SERVICE is provided by  MTechSoltion at no cost and is intended for use as is.Before Using this App you are reminded to read following privacy Statement."))
        PrivacyArray.append((title: "Personal Data", description: "ChinaIITax will not collect or keep your personal data that it will take your personal data for  calculating the tax."))
        
        
        PrivacyArray.append((title: "DATA SECURITY", description: "We value your trust in providing us with your Personal Information, thus we are striving to use commercially acceptable means of protecting it. Always remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security."))
        PrivacyArray.append((title: "CHANGES TO THIS PRIVACY POLICY", description: "We may update our Privacy Policy from time to time. Thus, you are advised to review privacy policy periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately after they are posted on this page."))
        PrivacyArray.append((title: "Tax Acuracy", description: "The result calculated by this app is only for reference.Mtech makes no gurantee on accuracy of result of calculation."))
        PrivacyArray.append((title: "CONTACT US", description: "If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us. Email: v0m66u@163.com"))
        privacyTableView.delegate = self
        privacyTableView.dataSource = self
    }
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PrivacyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = privacyTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PrivacyCell
        cell.titleLabel.text = PrivacyArray[indexPath.row].title
        cell.descriptionLabel.text = PrivacyArray[indexPath.row].description
        return cell
    }
    

}
