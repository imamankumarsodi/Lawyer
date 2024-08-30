//
//  EmptyWithAlertTableViewCell.swift
//  Lawyer
//
//  Created by Aman Kumar on 04/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class EmptyWithAlertTableViewCell: SBaseTableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var viewBG: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
