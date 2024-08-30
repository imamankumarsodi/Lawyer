//
//  FilterTableViewCellAndXib.swift
//  Lawyer
//
//  Created by Aman Kumar on 06/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class FilterTableViewCellAndXib: SBaseTableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var imageVie: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var btnSelectRef: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        setUpCell()
    }
    
    //MARK: - User Define Functions
    //TODO: Config TableViewCell
    
    public func configure(with info: FilterViewModel) {
        self.labelTitle.text = info.title
        if info.isSelected{
            self.imageVie.setImageTintColor(AppColor.app_gradient_color1)
            self.imageVie.image = UIImage(systemName: "checkmark.square.fill")
        }else{
            self.imageVie.setImageTintColor(AppColor.placeholderColor)
            self.imageVie.image = UIImage(systemName: "square")
        }
        
    }
    
    //TODO: Setup cell implementation
    private func setUpCell(){
        
        self.labelTitle.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        self.labelTitle.textColor = AppColor.darkGrayColor
        self.labelTitle.numberOfLines = 0
        
    }
 
}
