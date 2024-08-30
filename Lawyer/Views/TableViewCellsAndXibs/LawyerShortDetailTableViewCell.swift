//
//  LawyerShortDetailTableViewCell.swift
//  Lawyer
//
//  Created by Aman Kumar on 21/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class LawyerShortDetailTableViewCell: SBaseTableViewCell {
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var viewBG: UIView!
    
    @IBOutlet weak var imageLawyer: UIImageView!
    @IBOutlet weak var labelNameLayer: UILabel!
    
    
    @IBOutlet weak var imageLawyerExp: UIImageView!
    @IBOutlet weak var labelNameLayerExp: UILabel!
    
    @IBOutlet weak var imageLawyerLoc: UIImageView!
    @IBOutlet weak var labelNameLayerLoc: UILabel!
    
    @IBOutlet weak var imageLawyerLang: UIImageView!
    @IBOutlet weak var labelNameLayerLang: UILabel!
    
    @IBOutlet weak var imageLawyerNav: UIImageView!
    
    @IBOutlet weak var viewSeprator1: UIView!
    
    @IBOutlet weak var labelExperience: UILabel!
    @IBOutlet weak var labelCall: UILabel!
    @IBOutlet weak var labelMeet: UILabel!
    
    @IBOutlet weak var viewSeprator2: UIView!
    
    @IBOutlet weak var buttonMeetRef: UIButton!
    @IBOutlet weak var buttonCallRef: UIButton!
    
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
    }
    
    
    //TODO: Setup cell implementation
    private func setUpCell(){
        
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
        self.imageLawyerNav.isHidden = true
        
        self.backgroundColor = AppColor.tableBGColor
        self.viewBG.backgroundColor = AppColor.whiteColor
        self.customMethodManager?.provideShadowAndCornerRadius(self.viewBG, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, 2, 2, 2, 2, 0, AppColor.tableBGColor)
        
        self.imageLawyer.setImageTintColor(AppColor.darkGrayColor)
        
        self.labelNameLayer.font = UIFont.systemFont(ofSize: 15.0)
        self.labelNameLayer.textColor = AppColor.textColor
        
        self.imageLawyerExp.setImageTintColor(AppColor.app_gradient_color2)
        self.labelNameLayerExp.font = UIFont.systemFont(ofSize: 15.0)
        self.labelNameLayerExp.textColor = AppColor.darkGrayColor
        
        self.imageLawyerLoc.setImageTintColor(AppColor.app_gradient_color1)
        self.labelNameLayerLoc.font = UIFont.systemFont(ofSize: 15.0)
        self.labelNameLayerLoc.textColor = AppColor.darkGrayColor
        
        
        self.imageLawyerLang.setImageTintColor(AppColor.app_gradient_color1)
        self.labelNameLayerLang.font = UIFont.systemFont(ofSize: 15.0)
        self.labelNameLayerLang.textColor = AppColor.darkGrayColor
        
        self.imageLawyerNav.setImageTintColor(AppColor.app_gradient_color1)
        
        self.viewSeprator1.backgroundColor = AppColor.darkGrayColor
        self.viewSeprator2.backgroundColor = AppColor.darkGrayColor
        
        
        self.customMethodManager?.provideCornerRadiusTo(self.buttonMeetRef, 5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        self.customMethodManager?.provideCornerBorderTo(self.buttonMeetRef, 1, AppColor.app_gradient_color1)
        
        self.buttonMeetRef.setTitleColor(AppColor.app_gradient_color1, for: .normal)
        self.buttonMeetRef.backgroundColor = AppColor.whiteColor
        self.buttonMeetRef.setTitle(ConstantTexts.MeetBT, for: .normal)
        self.buttonMeetRef.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        
        
        self.customMethodManager?.provideCornerRadiusTo(self.buttonCallRef, 5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        self.buttonCallRef.setTitleColor(AppColor.whiteColor, for: .normal)
        self.buttonCallRef.backgroundColor = AppColor.app_gradient_color1
        self.buttonCallRef.setTitle(ConstantTexts.CallBT, for: .normal)
        self.buttonCallRef.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        
        //TODO: Values
        self.labelNameLayerExp.text = ConstantTexts.NALT
        self.labelNameLayer.text = "Jack Shukla"
        self.labelNameLayerLoc.text = "North West Delhi, India"
        self.labelNameLayerLang.text = "English, Hindi"
        
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points
        
        
        var myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: ConstantTexts.ExperienceLT, font: UIFont.systemFont(ofSize: 15.0), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\n \(15) \(ConstantTexts.YrsLT)", font: UIFont.systemFont(ofSize: 15.0), color: AppColor.textColor) ?? NSMutableAttributedString())
        
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        // *** Set Attributed String to your label ***
        
        self.labelExperience.attributedText = myMutableString
        
        
        
        
        
        myMutableString = NSMutableAttributedString()
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: ConstantTexts.CallLT, font: UIFont.systemFont(ofSize: 15.0), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\n\(ConstantTexts.CurLT)  \(500)", font: UIFont.systemFont(ofSize: 15.0), color: AppColor.textColor) ?? NSMutableAttributedString())
        
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        // *** Set Attributed String to your label ***
        
        self.labelCall.attributedText = myMutableString
        
        
        
        myMutableString = NSMutableAttributedString()
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: ConstantTexts.MeetLT, font: UIFont.systemFont(ofSize: 15.0), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\n\(ConstantTexts.CurLT)  \(2000)", font: UIFont.systemFont(ofSize: 15.0), color: AppColor.textColor) ?? NSMutableAttributedString())
        
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        // *** Set Attributed String to your label ***
        
        self.labelMeet.attributedText = myMutableString
        
        
        
    }
    
    
}
