//
//  CategoryTableViewCellAndXib.swift
//  Lawyer
//
//  Created by Aman Kumar on 05/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class CategoryTableViewCellAndXib: SBaseTableViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var imageCategory: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var titlelLabelCategory: UILabel!
    @IBOutlet weak var imageRightArrow: UIImageView!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var btnCellSelectedRef: UIButton!
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    
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
    
    
    
    //TODO: Setup cell implementation
    private func setUpCell(){
        
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
        self.imageRightArrow.isHidden = true
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.viewBG, 0, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, 2, 2, 2, 2, 0, AppColor.tableBGColor)
        self.viewBG.backgroundColor = AppColor.whiteColor
        
        self.backgroundColor = AppColor.whiteColor
        self.lblTitle.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 16)
        self.lblTitle.textColor = AppColor.textColor
        self.lblTitle.numberOfLines = 0
        
        self.titlelLabelCategory.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 12)
        self.titlelLabelCategory.textColor = AppColor.darkGrayColor
        self.titlelLabelCategory.numberOfLines = 3
        
        
        
       /*
        self.imageCategory.setImageTintColor(AppColor.darkGrayColor)
        self.imageRightArrow.setImageTintColor(AppColor.darkGrayColor)
         */
    }
    
    
    //TODO: Configure with new info
    public func configureNew(with info: CategoryViewModel){
       /* self.customMethodManager?.setImage(imageView: self.imageCategory, url: info.Url) */
        self.customMethodManager?.setImage(imageView: self.imageCategory, url: info.Url)
        self.lblTitle.text = info.title
        self.titlelLabelCategory.text = info.Description
        self.imageCategory.contentMode = .scaleAspectFit
    }
    
}
