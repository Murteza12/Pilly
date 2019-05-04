//
//  colurCell.swift
//  Pilly
//
//  Created by Murtaza on 20/04/2019.
//  Copyright © 2019 Murtaza. All rights reserved.
//

import UIKit

class colorCell: UITableViewCell {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorNameLabel : UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    var colorObj : Colours! {
        didSet{
            self.colorView.backgroundColor = colorObj.color
            self.colorNameLabel.text = colorObj.colorName
        }
    }
   
}
