//
//  MedTableViewCell.swift
//  Pilly
//
//  Created by Murtaza on 25/04/2019.
//  Copyright © 2019 Murtaza. All rights reserved.
//

import UIKit

class MedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var medImage: UIImageView!
    
    @IBOutlet weak var mednameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dosagelabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
