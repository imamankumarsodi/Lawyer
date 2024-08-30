//
//  AfterRateTableViewCell.swift
//  Lawyer
//
//  Created by Aman Kumar on 26/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
import Cosmos

class AfterRateTableViewCell: SBaseTableViewCell {

    @IBOutlet weak var lblSuccess: UILabel!
    
    @IBOutlet weak var viewBG: UIView!
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblLawyerName: UILabel!
    @IBOutlet weak var imgExperience: UIImageView!
    @IBOutlet weak var lblExperience: UILabel!
    
    @IBOutlet weak var imgQualification: UIImageView!
    @IBOutlet weak var lblQualification: UILabel!
    
    @IBOutlet weak var viewRating: CosmosView!
    
    
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
       // self.customMethodManager?.setImage(imageView: self.imgProfile, url: info.ProfilePhoto)
        self.lblLawyerName.text = info.LawyerName
        self.lblExperience.text = info.Experience
        self.lblQualification.text = info.Qualification
        
        
        
        
        
        self.lblSuccess.numberOfLines = 0
        
        /* self.customMethodManager?.setImage(imageView: self.imageCategory, url: info.Url) */
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyleCenter = NSMutableParagraphStyle()
        paragraphStyleCenter.alignment = .center
        // *** set LineSpacing property in points ***
        paragraphStyleCenter.lineSpacing = 1 // Whatever line spacing you want in points
        
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.CosultationCompletedNewLT)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 14), color: AppColor.app_gradient_color1) ?? NSMutableAttributedString())
        
        
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(info.Review)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
        // *** Set Attributed String to your label ***
        self.lblSuccess.attributedText = myMutableString
       
        self.viewRating.rating = Double(info.IsRating) ?? 0.0
        
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
      
        self.lblLawyerName.font = AppFont.Regular.size(AppFontName.Verdana, size: 16)
        self.lblLawyerName.textColor = AppColor.app_gradient_color1
        self.lblLawyerName.numberOfLines = 0
        
        self.lblExperience.font = AppFont.Regular.size(AppFontName.Verdana, size: 10)
        self.lblExperience.textColor = AppColor.darkGrayColor
        self.lblExperience.numberOfLines = 0
        
        self.lblQualification.font = AppFont.Regular.size(AppFontName.Verdana, size: 10)
        self.lblQualification.textColor = AppColor.darkGrayColor
        self.lblQualification.numberOfLines = 0
        
        self.viewRating.sizeToFit()
        self.viewRating.backgroundColor = AppColor.clearColor
        self.viewRating.isUserInteractionEnabled = false
     
    }
    
    
}
