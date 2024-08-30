//
//  OrderStatusTableViewCell.swift
//  Lawyer
//
//  Created by Aman Kumar on 28/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class OrderStatusTableViewCell: SBaseTableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var lblDetails: UILabel!
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblLawyerName: UILabel!
    @IBOutlet weak var imgExperience: UIImageView!
    @IBOutlet weak var lblExperience: UILabel!
    
    @IBOutlet weak var imgQualification: UIImageView!
    @IBOutlet weak var lblQualification: UILabel!
    
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        setup()
    }
    
    //MARK: - User Define Functions
    //TODO: Configure with info
    public func configureNew(with info: OrederStatusDataModel){
        self.lblDetails.text = info.title
       // self.customMethodManager?.setImage(imageView: self.imgProfile, url: info.ProfilePhoto)
        self.lblLawyerName.text = info.LawyerName
        self.lblExperience.text = info.Experience
        self.lblQualification.text = info.Qualification
        
    }
    
    
    
    
    //TODO: setup with new info
    private func setup(){
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
        
        self.customMethodManager?.provideCornerRadiusTo(self.imgProfile, 5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        self.customMethodManager?.provideCornerBorderTo(self.imgProfile, 0.5, AppColor.darkGrayColor)
        
        self.imgExperience.setImageTintColor(AppColor.darkGrayColor)
        self.imgQualification.setImageTintColor(AppColor.darkGrayColor)
        //self.imgProfile.setImageTintColor(AppColor.darkGrayColor)
        
        self.viewBG.backgroundColor = AppColor.tableBGColor
        self.viewLine.backgroundColor = AppColor.app_gradient_color1
        self.customMethodManager?.provideCornerRadiusTo(self.viewBG, 5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        self.lblDetails.font = AppFont.Regular.size(AppFontName.Verdana, size: 10)
        self.lblDetails.textColor = AppColor.darkGrayColor
        self.lblDetails.numberOfLines = 0
        
        self.lblLawyerName.font = AppFont.Regular.size(AppFontName.Verdana, size: 16)
        self.lblLawyerName.textColor = AppColor.app_gradient_color1
        self.lblLawyerName.numberOfLines = 0
        
        self.lblExperience.font = AppFont.Regular.size(AppFontName.Verdana, size: 10)
        self.lblExperience.textColor = AppColor.darkGrayColor
        self.lblExperience.numberOfLines = 0
        
        self.lblQualification.font = AppFont.Regular.size(AppFontName.Verdana, size: 10)
        self.lblQualification.textColor = AppColor.darkGrayColor
        self.lblQualification.numberOfLines = 0
        
        
    }
    
   
}
