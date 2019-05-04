//
//  PrivacyCell.swift
//  Pilly
//
//  Created by Murtaza on 02/05/2019.
//  Copyright © 2019 Murtaza. All rights reserved.
//

import UIKit

class PrivacyCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
